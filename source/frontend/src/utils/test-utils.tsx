import { useKeycloak } from '@react-keycloak/web';
import {
  act,
  fireEvent,
  render as rtlRender,
  RenderOptions as RtlRenderOptions,
  RenderResult,
  waitFor,
} from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { AxiosError, AxiosRequestHeaders, AxiosResponse } from 'axios';
import { createMemoryHistory, MemoryHistory } from 'history';
import noop from 'lodash/noop';
import React, { ReactNode } from 'react';
import { MapContainer } from 'react-leaflet';
import { Router } from 'react-router-dom/cjs/react-router-dom';
import { vi } from 'vitest';

import { IMapStateMachineContext } from '@/components/common/mapFSM/MapStateMachineContext';
import { FilterProvider } from '@/components/maps/providers/FilterProvider';
import { IApiError } from '@/interfaces/IApiError';
import { mapMachineBaseMock } from '@/mocks/mapFSM.mock';

import TestCommonWrapper from './TestCommonWrapper';

const mocks = vi.hoisted(() => {
  return {
    useKeycloak: vi.fn(),
    useMapStateMachine: vi.fn().mockImplementation(() => mapMachineBaseMock),
  };
});

vi.mock('@/components/common/mapFSM/MapStateMachineContext', () => {
  return {
    useMapStateMachine: mocks.useMapStateMachine,
    MapStateMachineProvider: vi.fn(),
  };
});

vi.mock('@react-keycloak/web', () => {
  return {
    useKeycloak: mocks.useKeycloak,
  };
});

interface Option {
  id: number | string;
  text: string;
}

export const mockKeycloak = (
  props: {
    claims?: string[];
    roles?: string[];
    organizations?: number[];
    authenticated?: boolean;
    userInfo?: any;
    subject?: string;
  } = {},
) => {
  const { claims, roles, organizations, authenticated = true, userInfo, subject } = props;
  // mock what would be returned by keycloak userinfo endpoint
  const defaultUserInfo = {
    organizations: organizations ?? [1],
    client_roles: [...(claims ?? []), ...(roles ?? [])],
    email: 'test@test.com',
    name: 'Chester Tester',
    idir_user_guid: '00000000000000000000000000000000',
    sub: '00000000000000000000000000000000@idir',
  };

  mocks.useKeycloak.mockImplementation(() => ({
    keycloak: {
      userInfo: userInfo ?? defaultUserInfo,
      subject: subject ?? 'test',
      authenticated,
      loadUserInfo: vi.fn().mockResolvedValue(userInfo ?? defaultUserInfo),
    } as any,
    initialized: true,
  }));
};

/**
 * Generates fake text data to aid testing input form validation.
 * @param length The length of the text to generate.
 * @returns A string with as many 'x' as the supplied length
 */
export function fakeText(length = 50): string {
  return 'x'.repeat(length);
}

/**
 * Utility method to wait for async effects to finish - e.g useEffect()
 * @returns a Promise
 */
export const waitForEffects = async () => {
  return act(noop);
};

/**
 * Select/deselect the given options in an HTMLSelectElement
 * @param elementName The select name
 * @param values the value to select
 * @returns A promise
 */
export const selectOptions = async (elementName: string, values: string[] | string) => {
  const element: HTMLSelectElement | null = document.querySelector(`select[name="${elementName}"]`);
  if (!element) {
    throw new Error(`Could not find element with name: ${elementName}`);
  }
  return userEvent.selectOptions(element, values);
};

/**
 * Finds a DOM element by its name.
 * @param elementName The HTML element name
 * @returns The element (or null if not found in the DOM)
 */
export const getByName = (elementName: string) => {
  return elementName ? (document.querySelector(`[name="${elementName}"]`) as HTMLElement) : null;
};

export const fillInput = async (
  container: HTMLElement,
  name: string,
  value: any,
  type = 'input',
) => {
  let input: Element | null = null;

  if (type === 'radio') {
    input = container.querySelector(`#input-${name}`);
  } else {
    if (type === 'typeahead' || type === 'datepicker') {
      input = container.querySelector(`input[name="${name}"]`);
    } else {
      input = container.querySelector(`${type}[name="${name}"]`);
    }
  }

  // abort early if no input field found
  if (!input) return { input };
  if (type === 'input') {
    fireEvent.change(input, {
      target: {
        value: value,
      },
    });
    fireEvent.focusOut(input);
  } else if (type === 'typeahead') {
    fireEvent.focus(input);
    fireEvent.change(input, {
      target: {
        value: value,
      },
    });
    const select = container.querySelector(`[aria-label="${value}"]`);
    select && fireEvent.click(select);
    fireEvent.focusOut(input);
  } else if (type === 'datepicker') {
    fireEvent.mouseDown(input);
    fireEvent.change(input, {
      target: {
        value: value,
      },
    });
    fireEvent.keyPress(input, { key: 'Enter', code: 'Enter' });
  } else if (type === 'radio') {
    fireEvent.click(input);
    fireEvent.focusOut(input);
  } else {
    fireEvent.change(input, {
      target: {
        value: value,
      },
    });
  }
  fireEvent.blur(input);

  return { input };
};

window.setImmediate = window.setTimeout as any;

export const deferred = () => {
  let resolve: (value?: unknown) => void = noop;
  const promise = new Promise(_resolve => {
    resolve = _resolve;
  });
  return {
    resolve,
    promise,
  };
};

/**
 * Creates an AxiosError with the specified message, config, error code, request and response.
 * @param status The HTTP status code from the server response.
 * @param message The error message.
 * @param data The response that was provided by the server.
 * @returns The created error.
 */
export function createAxiosError(
  status = 500,
  message = 'Internal Server Error',
  data: any = {},
  type?: string,
): AxiosError<IApiError> {
  return {
    isAxiosError: true,
    name: 'AxiosError',
    message,
    config: { headers: {} as AxiosRequestHeaders },
    toJSON: noop as any,
    response: {
      status,
      data: {
        ...data,
        type: type,
        error: message,
      },
    } as AxiosResponse<IApiError>,
  };
}

/**
 * Utility type for generic props of component testing
 */
export interface PropsWithChildren {
  children?: ReactNode;
}

const defaultHistory = createMemoryHistory({
  getUserConfirmation: (message, callback) => callback(true),
});

/**
 * Creates a in-memory router for unit testing
 * @param history (optional) a memory history to use instead of default
 * @returns The route provider
 */
export function createRouteProvider(history?: MemoryHistory) {
  return function Wrapper({ children }: PropsWithChildren) {
    return <Router history={history ?? defaultHistory}>{children}</Router>;
  };
}

/**
 * Creates a Map wrapper for unit testing
 * @param done A callback that will be called when the map has finished rendering
 * @returns The map container instance
 *
 * @example
 *    const { promise, resolve } = deferred();
 *    render(<TestComponent/>, { wrapper: createMapContainer(resolve) })
 *    await waitFor(() => promise)
 *    // the map is fully initialized here...
 */
export function createMapContainer(
  done: () => void = noop,
  whenCreated: (map: L.Map) => void = noop,
) {
  return function Container({ children }: PropsWithChildren) {
    return (
      <div id="mapid" style={{ width: 500, height: 500 }}>
        <MapContainer center={[48.43, -123.37]} zoom={14} whenReady={done} ref={whenCreated}>
          {children}
        </MapContainer>
      </div>
    );
  };
}

// override RenderOptions interface
export interface RenderOptions extends RtlRenderOptions {
  store?: any;
  history?: MemoryHistory;
  useMockAuthentication?: boolean;
  organizations?: number[];
  claims?: string[];
  roles?: string[];
  mockMapMachine?: IMapStateMachineContext;
  keycloakMock?: any;
}

function render(
  ui: React.ReactElement,
  options: Omit<RenderOptions, 'wrapper'> = {},
): RenderResult {
  const {
    store,
    history,
    useMockAuthentication = false,
    organizations,
    claims,
    roles,
    mockMapMachine = mapMachineBaseMock,
    keycloakMock,
    ...renderOptions
  } = options;

  // mock authentication state prior to rendering. Check first that keycloak has been mocked!
  if (!!useMockAuthentication || !!claims || !!roles || !!organizations) {
    if (typeof vi.mocked(useKeycloak).mockReturnValue === 'function') {
      mockKeycloak(
        keycloakMock?.keycloak ?? {
          claims: claims ?? [],
          roles: roles ?? [],
          organizations: organizations ?? [1],
          authenticated: true,
        },
      );
    }
  }

  mocks.useMapStateMachine.mockImplementation(() => mockMapMachine);

  function AllTheProviders({ children }: PropsWithChildren) {
    return (
      <TestCommonWrapper store={store} history={history}>
        <FilterProvider>{children}</FilterProvider>
      </TestCommonWrapper>
    );
  }
  return rtlRender(ui, { wrapper: AllTheProviders, ...renderOptions });
}

async function renderAsync(
  ui: React.ReactElement,
  options: Omit<RenderOptions, 'wrapper'> = {},
): Promise<RenderResult> {
  const {
    store,
    history,
    useMockAuthentication = false,
    organizations,
    claims,
    roles,
    mockMapMachine = mapMachineBaseMock,
    keycloakMock,
    ...renderOptions
  } = options;

  // mock authentication state prior to rendering. Check first that keycloak has been mocked!
  if (!!useMockAuthentication || !!claims || !!roles || !!organizations) {
    if (typeof vi.mocked(useKeycloak).mockReturnValue === 'function') {
      mockKeycloak(
        keycloakMock?.keycloak ?? {
          claims: claims ?? [],
          roles: roles ?? [],
          organizations: organizations ?? [1],
          authenticated: true,
        },
      );
    }
  }

  mocks.useMapStateMachine.mockImplementation(() => mockMapMachine);

  function AllTheProviders({ children }: PropsWithChildren) {
    return (
      <TestCommonWrapper store={store} history={history}>
        <FilterProvider>{children}</FilterProvider>
      </TestCommonWrapper>
    );
  }
  return await rtlRender(ui, { wrapper: AllTheProviders, ...renderOptions });
}

// simulate scrolling down using the keyboard arrows
export async function focusOptionMultiselect(
  container: HTMLElement,
  option: Option,
  options: readonly Option[],
) {
  const indexOfSelectedOption = options.findIndex(o => o.id === option.id);
  for (let i = 0; i < indexOfSelectedOption; i++) {
    await act(async () => {
      userEvent.keyboard('{ArrowDown}');
    });
  }
  expect(
    container.querySelector('.multiselect-container .optionContainer li.option.highlight')!
      .textContent,
  ).toEqual(option.text);

  await waitFor(async () => {
    await act(async () => {
      userEvent.click(
        container.querySelector('.multiselect-container .optionContainer li.option.highlight')!,
      );
    });
  });
}

export const getMockRepositoryObj = (response = undefined) => ({
  error: undefined,
  response,
  execute: vi.fn().mockResolvedValue(response),
  loading: false,
  status: 200,
});

// re-export everything from RTL
export * from '@testing-library/react';
export { default as userEvent } from '@testing-library/user-event';
// override render method
export { render, renderAsync };
