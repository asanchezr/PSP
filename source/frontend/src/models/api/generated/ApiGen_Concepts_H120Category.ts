/**
 * File autogenerated by TsGenerator.
 * Do not manually modify, changes made to this file will be lost when this file is regenerated.
 */
import { UtcIsoDateTime } from '@/models/api/UtcIsoDateTime';

import { ApiGen_Base_BaseAudit } from './ApiGen_Base_BaseAudit';

// LINK: @backend/apimodels/Models/Concepts/H120Category/H120CategoryModel.cs
export interface ApiGen_Concepts_H120Category extends ApiGen_Base_BaseAudit {
  id: number | null;
  financialActivityId: number | null;
  workActivityId: number | null;
  costTypeId: number | null;
  h120CategoryNo: number | null;
  description: string | null;
  expiryDate: UtcIsoDateTime | null;
  isDisabled: boolean | null;
}
