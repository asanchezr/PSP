import { createMemoryHistory } from 'history';

import { mockFinancialCode } from '@/mocks/index.mock';
import { ApiGen_Concepts_FinancialCode } from '@/models/api/generated/ApiGen_Concepts_FinancialCode';
import { act, createAxiosError, render, RenderOptions, screen } from '@/utils/test-utils';

import AddFinancialCodeContainer, { IAddFinancialCodeFormProps } from './AddFinancialCodeContainer';

const mockApi = {
  error: undefined,
  response: undefined,
  execute: vi.fn(),
  loading: false,
};

vi.mock('@/hooks/repositories/useFinancialCodeRepository', () => ({
  useFinancialCodeRepository: () => {
    return {
      addFinancialCode: mockApi,
    };
  },
}));

const history = createMemoryHistory();

let viewProps: IAddFinancialCodeFormProps | undefined;

const TestView: React.FC<IAddFinancialCodeFormProps> = props => {
  viewProps = props;
  return <span>Content Rendered</span>;
};

describe('AddFinancialCode container', () => {
  const setup = (renderOptions: RenderOptions = {}) => {
    const utils = render(<AddFinancialCodeContainer View={TestView} />, {
      ...renderOptions,
      history,
    });
    return { ...utils };
  };

  beforeEach(() => {
    viewProps = undefined;
    vi.resetAllMocks();
  });

  it('renders the underlying form', () => {
    const { getByText } = setup();
    expect(getByText(/Content Rendered/)).toBeVisible();
  });

  it('displays error message for duplicate codes', async () => {
    const { getByText } = setup();

    await act(async () => {
      const error409 = createAxiosError(409, 'Duplicate code found');
      viewProps?.onError(error409);
    });

    expect(getByText(/Cannot create duplicate financial code/)).toBeVisible();
  });

  it('displays a toast for generic server errors', async () => {
    setup();

    await act(async () => {
      const error500 = createAxiosError(500);
      viewProps?.onError(error500);
    });

    expect(await screen.findByText('Unable to save. Please try again.')).toBeVisible();
  });

  it('makes request to create a new financial code and returns the response', async () => {
    setup();
    mockApi.execute.mockResolvedValue(mockFinancialCode());

    let createdCode: ApiGen_Concepts_FinancialCode | undefined;
    await act(async () => {
      createdCode = await viewProps?.onSave({} as ApiGen_Concepts_FinancialCode);
    });

    expect(mockApi.execute).toHaveBeenCalled();
    expect(createdCode).toStrictEqual({ ...mockFinancialCode() });
  });

  it('navigates back to financial codes list when form is cancelled', async () => {
    setup();
    await act(async () => {
      viewProps?.onCancel();
    });
    expect(history.location.pathname).toBe(`/admin/financial-code/list`);
  });

  it('navigates back to financial codes list and displays a toast when code is saved', async () => {
    setup();
    await act(async () => {
      await viewProps?.onSuccess({} as ApiGen_Concepts_FinancialCode);
    });
    expect(history.location.pathname).toBe(`/admin/financial-code/list`);
  });
});
