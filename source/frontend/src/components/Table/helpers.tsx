import { CellProps } from 'react-table';

import { ApiGen_Base_CodeType } from '@/models/api/generated/ApiGen_Base_CodeType';
import { formatMoney, prettyFormatDate, stringToFragment } from '@/utils';

/**
 * These helper methods below provide ways to render common values on a Table cell;
 *  - dates
 *  - money
 *  - percentages
 */

export const renderDate = <T extends object>({
  cell: { value },
}: CellProps<T, string | Date | undefined>) => stringToFragment(prettyFormatDate(value));

export const renderMoney = <T extends object>({
  cell: { value },
}: CellProps<T, number | '' | undefined>) => stringToFragment(formatMoney(value));

export const renderBooleanAsYesNo = ({ value }: CellProps<any, boolean | undefined>) =>
  stringToFragment(value ? 'Y' : 'N');

export const renderTypeCode = ({
  value,
}: CellProps<any, ApiGen_Base_CodeType<any> | undefined | null>) =>
  stringToFragment(value?.description ?? '');

export const renderGenTypeCode = ({
  value,
}: CellProps<any, ApiGen_Base_CodeType<any> | undefined | null>) =>
  stringToFragment(value?.description ?? '');
