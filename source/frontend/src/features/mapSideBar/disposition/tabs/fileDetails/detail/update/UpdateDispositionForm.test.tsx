import axios from 'axios';
import MockAdapter from 'axios-mock-adapter';
import { FormikProps } from 'formik';
import { createRef } from 'react';

import { DispositionFormModel } from '@/features/mapSideBar/disposition/models/DispositionFormModel';
import { mockDispositionFileResponse } from '@/mocks/dispositionFiles.mock';
import { mockLookups } from '@/mocks/lookups.mock';
import { lookupCodesSlice } from '@/store/slices/lookupCodes';
import { act, render, RenderOptions, userEvent } from '@/utils/test-utils';

import UpdateDispositionForm, { IUpdateDispositionFormProps } from './UpdateDispositionForm';

const mockAxios = new MockAdapter(axios);

// mock auth library
jest.mock('@react-keycloak/web');

const onSubmit = jest.fn();
const ref = createRef<FormikProps<DispositionFormModel>>();

// Need to mock this library for unit tests
jest.mock('react-visibility-sensor', () => {
  return jest.fn().mockImplementation(({ children }) => {
    if (children instanceof Function) {
      return children({ isVisible: true });
    }
    return children;
  });
});

describe('UpdateDispositionForm component', () => {
  // render component under test
  const setup = (props: IUpdateDispositionFormProps, renderOptions: RenderOptions = {}) => {
    const utils = render(
      <UpdateDispositionForm
        formikRef={ref}
        initialValues={props.initialValues}
        onSubmit={props.onSubmit}
        loading={props.loading}
      />,
      {
        ...renderOptions,
        claims: [],
        store: {
          [lookupCodesSlice.name]: { lookupCodes: mockLookups },
        },
      },
    );

    return {
      ...utils,
      getFormikRef: () => ref,
      getTeamMemberProfileDropDownList: (index: number = 0) =>
        utils.container.querySelector(
          `select[name="team.${index}.teamProfileTypeCode"]`,
        ) as HTMLSelectElement,
    };
  };

  let initialValues: DispositionFormModel;

  beforeEach(() => {
    initialValues = DispositionFormModel.fromApi(mockDispositionFileResponse());
  });

  afterEach(() => {
    mockAxios.resetHistory();
    jest.clearAllMocks();
  });

  it('renders as expected', async () => {
    const { asFragment } = setup({ initialValues, loading: false, formikRef: ref, onSubmit });
    expect(asFragment()).toMatchSnapshot();
  });

  it('renders loading spinner', async () => {
    const { getByTestId } = setup({ initialValues, loading: true, formikRef: ref, onSubmit });
    expect(getByTestId('filter-backdrop-loading')).toBeVisible();
  });

  it('it validates that only profile is not repeated on another team member', async () => {
    const { getByTestId, queryByTestId, getTeamMemberProfileDropDownList } = setup({
      initialValues,
      loading: false,
      formikRef: ref,
      onSubmit,
    });

    // Set duplicate should fail
    await act(async () => {
      userEvent.selectOptions(getTeamMemberProfileDropDownList(0), 'NEGOTAGENT');
    });

    expect(getByTestId('team-profile-dup-error')).toBeVisible();

    // Set unique should pass
    await act(async () => {
      userEvent.selectOptions(getTeamMemberProfileDropDownList(0), 'MOTILEAD');
    });

    expect(queryByTestId(/team-profile-dup-error/i)).toBeNull();
  });
});