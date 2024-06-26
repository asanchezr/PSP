import { ApiGen_Concepts_CompensationFinancial } from '@/models/api/generated/ApiGen_Concepts_CompensationFinancial';
import { ApiGen_Concepts_FinancialCodeTypes } from '@/models/api/generated/ApiGen_Concepts_FinancialCodeTypes';
import { EpochIsoDateTime } from '@/models/api/UtcIsoDateTime';
import { getEmptyBaseAudit } from '@/models/defaultInitializers';

export const mockCompReqH120s: () => ApiGen_Concepts_CompensationFinancial[] = () => [
  {
    id: 4,
    compensationId: 100,
    pretaxAmount: 99,
    isGstRequired: false,
    taxAmount: 1,
    totalAmount: 100,
    isDisabled: false,
    financialActivityCodeId: 3,
    financialActivityCode: {
      id: 3,
      type: ApiGen_Concepts_FinancialCodeTypes.BusinessFunction,
      displayOrder: null,
      effectiveDate: EpochIsoDateTime,
      expiryDate: null,
      code: null,
      description: null,
      ...getEmptyBaseAudit(),
    },
    h120CategoryId: null,
    appCreateTimestamp: '2023-05-09T00:16:17.293',
    appLastUpdateTimestamp: '2023-05-09T00:16:17.293',
    appLastUpdateUserid: 'dbo',
    appCreateUserid: 'dbo',
    rowVersion: 1,
    appCreateUserGuid: null,
    appLastUpdateUserGuid: null,
  },
  {
    id: 5,
    compensationId: 100,
    pretaxAmount: 1,
    isGstRequired: false,
    taxAmount: 99,
    totalAmount: 100,
    isDisabled: false,
    financialActivityCodeId: 3,
    financialActivityCode: {
      id: 3,
      type: ApiGen_Concepts_FinancialCodeTypes.BusinessFunction,
      displayOrder: null,
      effectiveDate: EpochIsoDateTime,
      expiryDate: null,
      code: null,
      description: null,
      ...getEmptyBaseAudit(),
    },
    appCreateTimestamp: '2023-05-09T00:16:17.293',
    appLastUpdateTimestamp: '2023-05-09T00:16:17.293',
    appLastUpdateUserid: 'dbo',
    appCreateUserid: 'dbo',
    rowVersion: 1,
    h120CategoryId: null,
    appCreateUserGuid: null,
    appLastUpdateUserGuid: null,
  },
  {
    id: 6,
    compensationId: 100,
    pretaxAmount: 999,
    isGstRequired: false,
    taxAmount: 1,
    totalAmount: 1000,
    isDisabled: false,
    financialActivityCodeId: 4,
    financialActivityCode: {
      id: 4,
      type: ApiGen_Concepts_FinancialCodeTypes.BusinessFunction,
      displayOrder: null,
      effectiveDate: EpochIsoDateTime,
      expiryDate: null,
      code: null,
      description: null,
      ...getEmptyBaseAudit(),
    },
    appCreateTimestamp: '2023-05-09T00:16:17.293',
    appLastUpdateTimestamp: '2023-05-09T00:16:17.293',
    appLastUpdateUserid: 'dbo',
    appCreateUserid: 'dbo',
    rowVersion: 1,
    h120CategoryId: null,
    appCreateUserGuid: null,
    appLastUpdateUserGuid: null,
  },
];
