import React from 'react';
import { Col, Row } from 'react-bootstrap';
import { FiCheck, FiMinus, FiX } from 'react-icons/fi';
import styled from 'styled-components';

import { EditButton } from '@/components/common/buttons/EditButton';
import { Section } from '@/components/common/Section/Section';
import { SectionField } from '@/components/common/Section/SectionField';
import { StyledEditWrapper, StyledSummarySection } from '@/components/common/Section/SectionStyles';
import TooltipIcon from '@/components/common/TooltipIcon';
import { UserNameTooltip } from '@/components/common/UserNameTooltip';
import { Claims } from '@/constants/index';
import { cannotEditMessage } from '@/features/mapSideBar/acquisition/common/constants';
import { useKeycloakWrapper } from '@/hooks/useKeycloakWrapper';
import { useLookupCodeHelpers } from '@/hooks/useLookupCodeHelpers';
import { ApiGen_CodeTypes_ChecklistItemStatusTypes } from '@/models/api/generated/ApiGen_CodeTypes_ChecklistItemStatusTypes';
import { ApiGen_Concepts_FileWithChecklist } from '@/models/api/generated/ApiGen_Concepts_FileWithChecklist';
import { prettyFormatUTCDate } from '@/utils';
import { isDefaultState, lastModifiedBy, sortByDisplayOrder } from '@/utils/fileUtils';

import { StyledChecklistItemStatus, StyledSectionCentered } from './styles';

export interface IChecklistViewProps {
  apiFile?: ApiGen_Concepts_FileWithChecklist;
  onEdit: () => void;
  isFileFinalStatus?: boolean;
  prefix?: string;
  sectionTypeName: string;
  editClaim: Claims;
  showEditButton: boolean;
}

export const ChecklistView: React.FC<IChecklistViewProps> = ({
  apiFile,
  prefix,
  onEdit,
  isFileFinalStatus,
  sectionTypeName,
  editClaim,
  showEditButton,
}) => {
  const keycloak = useKeycloakWrapper();
  const { getByType } = useLookupCodeHelpers();
  const sectionTypes = getByType(sectionTypeName);

  const checklist = apiFile?.fileChecklistItems || [];
  const lastUpdated = lastModifiedBy(checklist);

  return (
    <StyledSummarySection>
      {showEditButton && (
        <StyledEditWrapper className="mr-3 my-1">
          {keycloak.hasClaim(editClaim) && !isFileFinalStatus ? (
            <EditButton title="Edit checklist" onClick={onEdit} style={{ float: 'right' }} />
          ) : (
            isFileFinalStatus && (
              <TooltipIcon
                toolTipId={`lease-checklist-cannot-edit-tooltip`}
                toolTip={cannotEditMessage}
              />
            )
          )}
        </StyledEditWrapper>
      )}
      {lastUpdated && (
        <StyledSectionCentered>
          <em>
            {`This checklist was last updated ${prettyFormatUTCDate(
              lastUpdated.appLastUpdateTimestamp,
            )} by `}
            <UserNameTooltip
              userName={lastUpdated.appLastUpdateUserid}
              userGuid={lastUpdated.appLastUpdateUserGuid}
            />
          </em>
        </StyledSectionCentered>
      )}

      {sectionTypes.map((section, i) => (
        <Section
          key={section.id ?? `${prefix}-checklist-section-${i}`}
          header={section.name}
          isCollapsable
          initiallyExpanded
        >
          {checklist
            .filter(checklistItem => checklistItem.itemType?.sectionCode === section.id)
            .sort(sortByDisplayOrder)
            .map((checklistItem, j) => (
              <SectionField
                key={checklistItem.itemType?.code ?? `${prefix}-checklist-item-${j}`}
                label={checklistItem.itemType?.description ?? ''}
                tooltip={checklistItem.itemType?.hint}
                labelWidth={{ xl: 6, xs: 5 }}
                noGutters
              >
                <Row className="no-gutters">
                  <Col xl="6" xs="5">
                    <StyledChecklistItemAudit>
                      {!isDefaultState(checklistItem) && (
                        <>
                          <UserNameTooltip
                            userName={checklistItem.appLastUpdateUserid}
                            userGuid={checklistItem.appLastUpdateUserGuid}
                          />
                          <em> {prettyFormatUTCDate(checklistItem.appLastUpdateTimestamp)}</em>
                        </>
                      )}
                    </StyledChecklistItemAudit>
                  </Col>
                  <Col xl="5" xs="6">
                    <StyledChecklistItemStatus
                      color={mapStatusToColor(checklistItem.statusTypeCode?.id)}
                    >
                      {checklistItem.statusTypeCode?.description}
                    </StyledChecklistItemStatus>
                  </Col>
                  <Col xl="1" xs="1">
                    <StyledChecklistItemIcon>
                      <StatusIcon status={checklistItem.statusTypeCode?.id} />
                    </StyledChecklistItemIcon>
                  </Col>
                </Row>
              </SectionField>
            ))}
        </Section>
      ))}
    </StyledSummarySection>
  );
};

function mapStatusToColor(status: string | null | undefined): string | undefined {
  switch (status) {
    case ApiGen_CodeTypes_ChecklistItemStatusTypes.COMPLT:
      return '#2E8540';
    case ApiGen_CodeTypes_ChecklistItemStatusTypes.NOTAPP:
      return '#aaaaaa';
    default:
      return undefined;
  }
}

const StatusIcon: React.FC<{ status: string | null | undefined }> = ({ status }) => {
  const color = mapStatusToColor(status);
  switch (status) {
    case ApiGen_CodeTypes_ChecklistItemStatusTypes.INCOMP:
      return <FiX size="2rem" color={color} />;

    case ApiGen_CodeTypes_ChecklistItemStatusTypes.COMPLT:
      return <FiCheck size="2rem" color={color} />;

    case ApiGen_CodeTypes_ChecklistItemStatusTypes.NOTAPP:
      return <FiMinus size="2rem" color={color} />;

    default:
      return null;
  }
};

const StyledChecklistItemAudit = styled.span`
  min-width: 13rem;
  font-size: 1.1rem;
  font-style: italic;
  text-align: right;
  color: ${props => props.theme.css.activeActionColor};

  .tooltip-icon {
    color: ${props => props.theme.css.activeActionColor};
  }
`;

const StyledChecklistItemIcon = styled.span`
  min-width: 2.4rem;
  text-align: right;
`;
