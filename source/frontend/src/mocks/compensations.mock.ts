import { Api_Compensation } from 'models/api/Compensation';

export const getMockApiDefaultCompensation = (): Api_Compensation => ({
  id: 1,
  acquisitionFileId: 2,
  isDraft: true,
  fiscalYear: null,
  agreementDate: null,
  expropriationNoticeServedDate: null,
  expropriationVestingDate: null,
  generationDate: null,
  specialInstruction: null,
  detailedRemarks: null,
  isDisabled: false,
  financials: [],
  rowVersion: 1,
});

export const getMockApiCompensation = (): Api_Compensation => ({
  id: 1,
  acquisitionFileId: 2,
  isDraft: true,
  fiscalYear: null,
  agreementDate: null,
  expropriationNoticeServedDate: null,
  expropriationVestingDate: null,
  generationDate: null,
  specialInstruction: null,
  detailedRemarks: null,
  isDisabled: false,
  financials: [],
  rowVersion: 1,
});

export const getMockApiCompensationList = (): Api_Compensation[] => [
  {
    id: 1,
    acquisitionFileId: 2,
    isDraft: false,
    fiscalYear: null,
    agreementDate: null,
    expropriationNoticeServedDate: null,
    expropriationVestingDate: null,
    generationDate: null,
    specialInstruction: null,
    detailedRemarks: null,
    isDisabled: false,
    financials: [],
    rowVersion: 1,
  },
  {
    id: 2,
    acquisitionFileId: 2,
    isDraft: false,
    fiscalYear: null,
    agreementDate: null,
    expropriationNoticeServedDate: null,
    expropriationVestingDate: null,
    generationDate: null,
    specialInstruction: null,
    detailedRemarks: null,
    isDisabled: false,
    financials: [
      {
        id: 1,
        compensationId: 2,
        pretaxAmount: null,
        taxAmount: null,
        totalAmount: 10.0,
        isDisabled: false,
        rowVersion: 1,
      },
      {
        id: 2,
        compensationId: 2,
        pretaxAmount: null,
        taxAmount: null,
        totalAmount: 15.0,
        isDisabled: false,
        rowVersion: 1,
      },
      {
        id: 3,
        compensationId: 2,
        pretaxAmount: null,
        taxAmount: null,
        totalAmount: 3.0,
        isDisabled: false,
        rowVersion: 1,
      },
      {
        id: 4,
        compensationId: 2,
        pretaxAmount: null,
        taxAmount: null,
        totalAmount: 7.0,
        isDisabled: false,
        rowVersion: 1,
      },
    ],
    rowVersion: 1,
  },
  {
    id: 3,
    acquisitionFileId: 2,
    isDraft: false,
    fiscalYear: null,
    agreementDate: null,
    expropriationNoticeServedDate: null,
    expropriationVestingDate: null,
    generationDate: null,
    specialInstruction: null,
    detailedRemarks: null,
    isDisabled: false,
    financials: [],
    rowVersion: 1,
  },
  {
    id: 4,
    acquisitionFileId: 2,
    isDraft: true,
    fiscalYear: null,
    agreementDate: null,
    expropriationNoticeServedDate: null,
    expropriationVestingDate: null,
    generationDate: null,
    specialInstruction: null,
    detailedRemarks: null,
    isDisabled: false,
    financials: [],
    rowVersion: 1,
  },
  {
    id: 5,
    acquisitionFileId: 2,
    isDraft: true,
    fiscalYear: null,
    agreementDate: '2023-04-26T00:00:00',
    expropriationNoticeServedDate: null,
    expropriationVestingDate: null,
    generationDate: null,
    specialInstruction: null,
    detailedRemarks: null,
    isDisabled: false,
    financials: [
      {
        id: 5,
        compensationId: 5,
        pretaxAmount: null,
        taxAmount: null,
        totalAmount: 7.0,
        isDisabled: false,
        rowVersion: 1,
      },
    ],
    rowVersion: 1,
  },
  {
    id: 6,
    acquisitionFileId: 2,
    isDraft: true,
    fiscalYear: null,
    agreementDate: '2023-04-26T00:00:00',
    expropriationNoticeServedDate: null,
    expropriationVestingDate: null,
    generationDate: null,
    specialInstruction: null,
    detailedRemarks: null,
    isDisabled: false,
    financials: [],
    rowVersion: 1,
  },
];