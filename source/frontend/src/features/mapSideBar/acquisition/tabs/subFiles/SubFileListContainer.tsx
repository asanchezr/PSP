import { useHistory } from 'react-router-dom';

import { ApiGen_Concepts_AcquisitionFile } from '@/models/api/generated/ApiGen_Concepts_AcquisitionFile';

import { ISubFileListViewProps } from './SubFileListView';

export interface ISubFileListContainerProps {
  View: React.FC<ISubFileListViewProps>;
  acquisitionFile: ApiGen_Concepts_AcquisitionFile;
}

export const SubFileListContainer: React.FunctionComponent<ISubFileListContainerProps> = ({
  View,
  acquisitionFile,
}) => {
  const history = useHistory();

  // TODO: Add an "useEffect" to fetch the list of linked files from the backend API
  // Use this loading flag to render a spinner in the view while loading
  const loading = false;

  // Redirect to "Create Acquisition File" route for sub-file
  const onAddSubFile = (): void => {
    const params = new URLSearchParams();
    params.set('parentId', acquisitionFile.id.toString());
    history.replace({
      pathname: `/mapview/sidebar/acquisition/new`,
      search: params.toString(),
    });
  };

  return <View loading={loading} acquisitionFile={acquisitionFile} onAdd={onAddSubFile} />;
};

export default SubFileListContainer;
