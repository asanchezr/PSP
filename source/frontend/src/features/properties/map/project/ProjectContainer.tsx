import { FormikProps } from 'formik';
import { useProjectProvider } from 'hooks/providers/useProjectProvider';
import { IProjectForm } from 'interfaces/IProject';
import { Api_Project } from 'models/api/Project';
import { useCallback, useContext, useEffect, useReducer, useState } from 'react';
import * as Yup from 'yup';

import { SideBarContext } from '../context/sidebarContext';
import { ProjectForm } from './add/models';
import { ProjectTabNames } from './ProjectTabs';

export interface IProjectContainerViewProps {
  project?: Api_Project;
  viewTitle?: string;
  loadingProject?: boolean;
  activeTab?: ProjectTabNames;
  isEditing: boolean;
  onSetContainerState: (value: Partial<ProjectContainerState>) => void;
  onClose: () => void;
  onSetProject: (project: Api_Project) => void;
}

export interface IProjectContainerProps {
  projectId: number;
  onClose: () => void;
  View: React.FC<IProjectContainerViewProps>;
}

export interface ProjectPageProps {
  isEditing: boolean;
  onEdit?: (isEditing: boolean) => void;
  formikRef: React.RefObject<FormikProps<ProjectForm | IProjectForm>>;
}

export interface IProjectPage {
  component: React.FunctionComponent<React.PropsWithChildren<ProjectPageProps>>;
  title: string;
  description?: string;
  validation?: Yup.ObjectSchema<any>;
  claims?: string[] | string;
  editable?: boolean;
}

export enum ProjectPageNames {
  DETAILS = 'details',
}

export const projectPages: Map<ProjectPageNames, IProjectPage> = new Map<
  ProjectPageNames,
  IProjectPage
>([
  // [
  //   ProjectPageNames.DETAILS,
  //   {
  //     component: UpdateProjectContainer,
  //     title: 'Project details',
  //     validation: AddProjectYupSchema,
  //   },
  // ],
]);

// Interface for our internal state
export interface ProjectContainerState {
  isEditing: boolean;
  activeEditForm?: ProjectPageNames;
  activeTab?: ProjectTabNames;
  showConfirmModal: boolean;
}

const initialState: ProjectContainerState = {
  isEditing: false,
  activeEditForm: undefined,
  activeTab: undefined,
  showConfirmModal: false,
};

const ProjectContainer: React.FunctionComponent<
  React.PropsWithChildren<IProjectContainerProps>
> = ({ projectId, View, onClose }) => {
  const { setProject, setProjectLoading } = useContext(SideBarContext);

  const {
    getProject: { execute: getProject, loading: loadingProject },
  } = useProjectProvider();

  const [containerState, setContainerState] = useReducer(
    (prevState: ProjectContainerState, newState: Partial<ProjectContainerState>) => ({
      ...prevState,
      ...newState,
    }),
    initialState,
  );

  // Retrieve acquisition file from API and save it to local state and side-bar context
  const fetchProject = useCallback(async () => {
    var retrieved = await getProject(projectId);
    setProjectInstance(retrieved);
  }, [projectId, getProject]);

  const [project, setProjectInstance] = useState<Api_Project | undefined>(undefined);

  useEffect(() => {
    if (project === undefined) {
      fetchProject();
    }
  }, [project, fetchProject]);

  useEffect(() => setProjectLoading(loadingProject), [loadingProject, setProjectLoading]);

  const title = containerState.isEditing ? 'Update Project' : 'Project';
  return (
    <View
      project={project}
      viewTitle={title}
      activeTab={containerState.activeTab}
      loadingProject={loadingProject}
      isEditing={containerState.isEditing}
      onSetContainerState={setContainerState}
      onSetProject={setProject}
      onClose={onClose}
    />
  );
};

export default ProjectContainer;