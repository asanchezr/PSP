import orderBy from 'lodash/orderBy';
import { Link } from 'react-router-dom';
import { CellProps } from 'react-table';

import { UserNameTooltip } from '@/components/common/UserNameTooltip';
import { ColumnWithProps, renderDate, Table } from '@/components/Table';
import { ApiGen_Concepts_Association } from '@/models/api/generated/ApiGen_Concepts_Association';

interface IAssociationInfo {
  id: string;
  linkUrl: string;
  fileIdentifier: string;
  fileName: string;
  createdBy: string;
  createdByGuid: string;
  createdDate: string;
  status: string;
  disable: boolean;
}

export interface IAssociationContentProps {
  associationName: string;
  associations?: ApiGen_Concepts_Association[];
  linkUrlMask: string;
  disable?: boolean;
}

const AssociationContent: React.FunctionComponent<
  React.PropsWithChildren<IAssociationContentProps>
> = props => {
  const noDataMessage = `There are no ${props.associationName} files available`;
  if (props.associations === undefined) {
    return <>{noDataMessage}</>;
  }
  const tableData = orderBy(
    props.associations.map<IAssociationInfo>(x => {
      return {
        id: x.id?.toString() || '',
        linkUrl: props.linkUrlMask.replace('|id|', x.id?.toString() || ''),
        fileIdentifier: x.fileNumber || '',
        fileName: x.fileName || '',
        createdBy: x.createdBy || '',
        createdByGuid: x.createdByGuid || '',
        createdDate: x.createdDateTime || '',
        status: x.status || '',
        disable: props.disable ?? false,
      };
    }),
    (association: IAssociationInfo) => {
      return association.createdDate;
    },
    'desc',
  );

  return (
    <Table<IAssociationInfo>
      name="associationFiles"
      columns={associationColumns}
      data={tableData ?? []}
      manualSortBy={true}
      noRowsMessage={noDataMessage}
      hideToolbar
    ></Table>
  );
};

const associationColumns: ColumnWithProps<IAssociationInfo>[] = [
  {
    Header: 'File #',
    accessor: 'fileIdentifier',
    align: 'left',
    Cell: (props: CellProps<IAssociationInfo>) => {
      return props.row.original.disable ? (
        <>{props.row.original.fileIdentifier}</>
      ) : (
        <Link to={props.row.original.linkUrl}>{props.row.original.fileIdentifier}</Link>
      );
    },
    width: 50,
  },
  {
    Header: 'File name',
    accessor: 'fileName',
    align: 'left',
  },
  {
    Header: 'Created by',
    accessor: 'createdBy',
    align: 'left',
    width: 50,
    Cell: (props: CellProps<IAssociationInfo>) => {
      return (
        <UserNameTooltip
          userName={props.row.original?.createdBy}
          userGuid={props.row.original?.createdByGuid}
        />
      );
    },
  },
  {
    Header: 'Created date',
    accessor: 'createdDate',
    align: 'left',
    Cell: renderDate,
    width: 80,
  },
  {
    Header: 'Status',
    accessor: 'status',
    align: 'left',
    width: 60,
  },
];

export default AssociationContent;
