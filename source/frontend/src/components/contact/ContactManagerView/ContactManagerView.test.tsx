import userEvent from '@testing-library/user-event';
import noop from 'lodash/noop';

import { Claims } from '@/constants/claims';
import { useApiContacts } from '@/hooks/pims-api/useApiContacts';
import { IContactSearchResult } from '@/interfaces';
import {
  act,
  fillInput,
  mockKeycloak,
  render,
  RenderOptions,
  waitFor,
  waitForElementToBeRemoved,
} from '@/utils/test-utils';

import { defaultFilter } from './ContactFilterComponent/ContactFilterComponent';
import ContactManagerView from './ContactManagerView';
import { MockedFunction } from 'vitest';
import { MaybeMocked } from '@vitest/spy';
import { ApiGen_Concepts_ContactSummary } from '@/models/api/generated/ApiGen_Concepts_ContactSummary';
import { getEmptyContactSummary } from '@/mocks/contacts.mock';

// mock auth library

vi.mock('@/hooks/pims-api/useApiContacts');
const getContacts = vi.fn();
vi.mocked(useApiContacts).mockReturnValue({
  getContacts,
} as unknown as ReturnType<typeof useApiContacts>);

// render component under test
const setup = (renderOptions: RenderOptions = {}) => {
  const utils = render(
    <ContactManagerView
      selectedRows={[]}
      setSelectedRows={noop}
      showActiveSelector
      showSelectedRowCount
    />,
    {
      ...renderOptions,
    },
  );
  const searchButton = utils.getByTestId('search');
  return { searchButton, ...utils };
};

const setupMockSearch = (searchResults?: ApiGen_Concepts_ContactSummary[]) => {
  const results = searchResults ?? [];
  const len = results.length;
  getContacts.mockResolvedValue({
    data: {
      items: results,
      quantity: len,
      total: len,
      page: 1,
      pageIndex: 0,
    },
  });
};

const defaultPersonSearchResult: ApiGen_Concepts_ContactSummary = {
  ...getEmptyContactSummary(),
  id: '1',
  summary: 'summary',
  mailingAddress: '123 mock st',
  surname: 'last',
  firstName: 'first',
  email: 'email',
  municipalityName: 'city',
  provinceState: 'province',
  isDisabled: false,
};

const defaultPagedFilter = {
  ...defaultFilter,
  page: 1,
  quantity: 10,
  sort: undefined,
};

describe('ContactManagerView', () => {
  beforeEach(() => {
    getContacts.mockClear();
    mockKeycloak({ claims: [Claims.CONTACT_VIEW] });
  });

  it('matches snapshot', async () => {
    setupMockSearch();
    const { asFragment, getByTitle } = setup();
    await waitForElementToBeRemoved(getByTitle('table-loading'));

    const fragment = await waitFor(() => asFragment());
    expect(fragment).toMatchSnapshot();
  });

  it('searches by summary', async () => {
    setupMockSearch([defaultPersonSearchResult]);
    const { container, searchButton, findByText } = setup();

    fillInput(container, 'summary', 'asummary');
    await act(async () => userEvent.click(searchButton));

    expect(getContacts).toHaveBeenCalledWith(
      expect.objectContaining({
        ...defaultPagedFilter,
        summary: 'asummary',
      }),
    );

    expect(await findByText(/123 mock st/i)).toBeInTheDocument();
  });

  it('searches by city/municipality', async () => {
    setupMockSearch([{ ...defaultPersonSearchResult, municipalityName: 'victoria' }]);
    const { container, searchButton, findByText } = setup({});
    fillInput(container, 'municipality', 'victoria');
    await act(async () => userEvent.click(searchButton));

    expect(getContacts).toHaveBeenCalledWith(
      expect.objectContaining({ ...defaultPagedFilter, municipality: 'victoria' }),
    );

    expect(await findByText(/victoria/i)).toBeInTheDocument();
  });

  it('searches all by default', async () => {
    setupMockSearch([defaultPersonSearchResult]);
    const { container, searchButton } = setup({});
    const allButton = container.querySelector(`#input-all`);
    allButton && (await act(async () => userEvent.click(allButton)));
    await act(async () => userEvent.click(searchButton));

    expect(getContacts).toHaveBeenCalledWith(
      expect.objectContaining({ ...defaultPagedFilter, searchBy: 'all' }),
    );

    expect(allButton).toBeChecked();
  });

  it('searches organizations if radio option selected', async () => {
    setupMockSearch([defaultPersonSearchResult]);
    const { container, searchButton } = setup({});
    const organizationsButton = container.querySelector(`#input-organizations`);
    await act(async () => {
      organizationsButton && userEvent.click(organizationsButton);
    });
    await act(async () => userEvent.click(searchButton));

    expect(getContacts).toHaveBeenCalledWith(
      expect.objectContaining({ ...defaultPagedFilter, searchBy: 'organizations' }),
    );

    expect(organizationsButton).toBeChecked();
  });

  it('searches persons if radio option selected', async () => {
    setupMockSearch([defaultPersonSearchResult]);
    const { container, searchButton } = setup({});
    const personButton = container.querySelector(`#input-persons`);
    await act(async () => {
      personButton && userEvent.click(personButton);
    });
    await act(async () => userEvent.click(searchButton));

    expect(getContacts).toHaveBeenCalledWith(
      expect.objectContaining({ ...defaultPagedFilter, searchBy: 'persons' }),
    );

    expect(personButton).toBeChecked();
  });

  it('searches for active contacts by default', async () => {
    setupMockSearch([defaultPersonSearchResult]);
    const { container, searchButton } = setup({});
    const activeCheck = container.querySelector(`#input-activeContactsOnly`);
    await act(async () => userEvent.click(searchButton));

    expect(getContacts).toHaveBeenCalledWith(expect.objectContaining({ ...defaultPagedFilter }));

    expect(activeCheck).toBeChecked();
  });

  it('searches for inactive contacts if checkbox unchecked', async () => {
    setupMockSearch([defaultPersonSearchResult]);
    const { container } = setup({});
    const activeCheck = container.querySelector(`#input-activeContactsOnly`);
    expect(activeCheck).not.toBeNull();
    await act(async () => userEvent.click(activeCheck as Element));

    expect(getContacts).toHaveBeenCalledWith(
      expect.objectContaining({ ...defaultPagedFilter, activeContactsOnly: false }),
    );

    expect(activeCheck).not.toBeChecked();
  });

  it('displays an error when no matching records found', async () => {
    setupMockSearch();
    const { container, searchButton, findAllByText } = setup();

    fillInput(container, 'summary', 'a summary that does not exist');
    await act(async () => userEvent.click(searchButton));

    expect(getContacts).toHaveBeenCalledWith(
      expect.objectContaining({ ...defaultPagedFilter, summary: 'a summary that does not exist' }),
    );
    const toasts = await findAllByText('No Contacts match the search criteria');
    expect(toasts[0]).toBeVisible();
  });

  it('displays an error when when Search API is unreachable', async () => {
    // simulate a network error
    getContacts.mockRejectedValue(new Error('network error'));
    const { container, searchButton, findAllByText } = setup();

    fillInput(container, 'summary', 'a summary resulting in a network error');
    await act(async () => userEvent.click(searchButton));

    expect(getContacts).toHaveBeenCalledWith(
      expect.objectContaining({
        ...defaultFilter,
        summary: 'a summary resulting in a network error',
      }),
    );
    const toasts = await findAllByText('network error');
    expect(toasts[0]).toBeVisible();
  });
});
