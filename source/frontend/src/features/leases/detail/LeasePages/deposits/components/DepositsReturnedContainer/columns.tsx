import { Link } from 'react-router-dom';
import { CellProps } from 'react-table';
import styled from 'styled-components';

import { RemoveIconButton } from '@/components/common/buttons';
import EditButton from '@/components/common/buttons/EditButton';
import TooltipIcon from '@/components/common/TooltipIcon';
import { ColumnWithProps, renderDate, renderMoney } from '@/components/Table';
import Claims from '@/constants/claims';
import { cannotEditMessage } from '@/features/mapSideBar/acquisition/common/constants';
import useKeycloakWrapper from '@/hooks/useKeycloakWrapper';
import { ApiGen_Concepts_Contact } from '@/models/api/generated/ApiGen_Concepts_Contact';
import { ApiGen_Concepts_SecurityDeposit } from '@/models/api/generated/ApiGen_Concepts_SecurityDeposit';
import { ApiGen_Concepts_SecurityDepositReturn } from '@/models/api/generated/ApiGen_Concepts_SecurityDepositReturn';
import { isValidIsoDateTime } from '@/utils';
import { formatNames } from '@/utils/personUtils';

export class ReturnListEntry {
  public id: number;
  public depositTypeDescription: string;
  public terminationDate: string;
  public depositAmount: number;
  public claimsAgainst: number;
  public returnAmount: number;
  public interestPaid: number;
  public returnDate: string;
  public contactHolder?: ApiGen_Concepts_Contact;

  public constructor(
    baseDeposit: ApiGen_Concepts_SecurityDepositReturn,
    parentDeposit: ApiGen_Concepts_SecurityDeposit,
  ) {
    this.id = baseDeposit.id || -1;
    if (parentDeposit.depositType?.id === 'OTHER') {
      this.depositTypeDescription = (parentDeposit.otherTypeDescription || '') + ' (Other)';
    } else {
      this.depositTypeDescription = parentDeposit.depositType?.description || '';
    }

    this.terminationDate = isValidIsoDateTime(baseDeposit.terminationDate)
      ? baseDeposit.terminationDate
      : '';
    this.depositAmount = parentDeposit.amountPaid;
    this.claimsAgainst = baseDeposit.claimsAgainst || 0;
    this.returnAmount = baseDeposit.returnAmount || 0;
    this.interestPaid = baseDeposit.interestPaid || 0;
    this.returnDate = isValidIsoDateTime(baseDeposit.returnDate) ? baseDeposit.returnDate : '';
    this.contactHolder = baseDeposit.contactHolder || undefined;
  }
}

function renderHolder({
  row: { original },
}: CellProps<ReturnListEntry, ApiGen_Concepts_Contact | undefined>) {
  if (original.contactHolder) {
    const holder = original.contactHolder;
    if (holder.person) {
      return (
        <Link to={`/contact/${holder.id}`}>
          {formatNames([holder.person.firstName, holder.person.middleNames, holder.person.surname])}
        </Link>
      );
    } else if (holder.organization) {
      return <Link to={`/contact/${holder.id}`}>{holder.organization.name}</Link>;
    }
  }

  return <></>;
}

function depositActions(
  isFileFinalStatus: boolean,
  onEdit: (id: number) => void,
  onDelete: (id: number) => void,
) {
  return function ({ row: { original, index } }: CellProps<ReturnListEntry, string>) {
    const { hasClaim } = useKeycloakWrapper();
    if (isFileFinalStatus) {
      return (
        <TooltipIcon
          toolTipId={`deposit-returned-actions-cannot-edit-tooltip`}
          toolTip={cannotEditMessage}
        />
      );
    }
    return (
      <StyledIcons>
        {hasClaim(Claims.LEASE_EDIT) && (
          <EditButton title="edit deposit return" onClick={() => onEdit(original.id)} />
        )}
        {hasClaim(Claims.LEASE_EDIT) && (
          <RemoveIconButton
            title="delete deposit return"
            id={`delete-deposit-${index}`}
            onRemove={() => original?.id && onDelete(original.id)}
          />
        )}
      </StyledIcons>
    );
  };
}

export interface IPaymentColumnProps {
  isFileFinalStatus?: boolean;
  onEdit: (id: number) => void;
  onDelete: (id: number) => void;
}

export const getColumns = ({
  isFileFinalStatus,
  onEdit,
  onDelete,
}: IPaymentColumnProps): ColumnWithProps<ReturnListEntry>[] => {
  return [
    {
      Header: 'Deposit type',
      accessor: 'depositTypeDescription',
      maxWidth: 50,
    },
    {
      Header: 'Termination or Surrender date',
      accessor: 'terminationDate',
      align: 'right',
      maxWidth: 70,
      minWidth: 70,
      Cell: renderDate,
    },
    {
      Header: 'Deposit amount',
      accessor: 'depositAmount',
      align: 'right',
      maxWidth: 40,
      Cell: renderMoney,
    },
    {
      Header: 'Claims against deposit',
      accessor: 'claimsAgainst',
      align: 'right',
      maxWidth: 50,
      Cell: renderMoney,
    },
    {
      Header: 'Returned amount (without interest)',
      accessor: 'returnAmount',
      align: 'right',
      maxWidth: 50,
      Cell: renderMoney,
    },
    {
      Header: 'Interest paid',
      accessor: 'interestPaid',
      align: 'right',
      maxWidth: 50,
      Cell: renderMoney,
    },
    {
      Header: 'Return date',
      accessor: 'returnDate',
      align: 'right',
      maxWidth: 50,
      Cell: renderDate,
    },

    {
      Header: 'Payee name',
      accessor: 'contactHolder',
      maxWidth: 70,
      Cell: renderHolder,
    },
    {
      Header: 'Actions',
      align: 'right',
      minWidth: 30,
      maxWidth: 30,
      Cell: depositActions(isFileFinalStatus, onEdit, onDelete),
    },
  ];
};

const StyledIcons = styled.div`
  [id^='edit-depositreturn'] {
    color: ${props => props.theme.css.activeActionColor};
  }
  [id^='delete-depositreturn'] {
    color: ${props => props.theme.css.activeActionColor};
    :hover {
      color: ${({ theme }) => theme.bcTokens.surfaceColorPrimaryDangerButtonDefault};
    }
  }
  .btn.btn-primary {
    background-color: transparent;
  }
  display: flex;
  @media only screen and (max-width: 1199px) {
    display: block;
  }
`;
