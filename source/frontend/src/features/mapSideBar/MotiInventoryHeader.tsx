import { StyledIconButton } from 'components/common/buttons';
import TooltipWrapper from 'components/common/TooltipWrapper';
import LoadingBackdrop from 'components/maps/leaflet/LoadingBackdrop/LoadingBackdrop';
import ComposedProperty from 'features/properties/map/propertyInformation/ComposedProperty';
import { AssociatedPlan } from 'interfaces/ltsaModels';
import { Api_Property } from 'models/api/Property';
import React from 'react';
import { Col, Row } from 'react-bootstrap';
import { FaSearchPlus } from 'react-icons/fa';
import styled from 'styled-components';
import { pidFormatter } from 'utils';

import { HeaderField } from './tabs/HeaderField';

export interface IMotiInventoryHeaderProps {
  composedProperty: ComposedProperty;
  onZoom?: (apiProperty?: Api_Property | undefined) => void;
}

export const MotiInventoryHeader: React.FunctionComponent<IMotiInventoryHeaderProps> = props => {
  const pid = pidFormatter(props.composedProperty.pid);
  const ltsaData = props.composedProperty.ltsaWrapper?.response;
  const planNumbers =
    ltsaData === undefined
      ? []
      : (
          (ltsaData?.parcelInfo?.orderedProduct.fieldedData.associatedPlans ??
            []) as AssociatedPlan[]
        ).map(x => x.planNumber);

  const isLoading = props.composedProperty.composedLoading;
  return (
    <>
      <LoadingBackdrop show={isLoading} parentScreen={true} />
      <Row className="no-gutters">
        <Col>
          <Row className="no-gutters">
            <Col xs="8">
              <HeaderField label="Civic Address:" labelWidth={'3'} contentWidth="9">
                -
              </HeaderField>
            </Col>
            <Col>
              <HeaderField className="justify-content-end" label="PID:" contentWidth="5">
                {pid}
              </HeaderField>
            </Col>
          </Row>
          <Row className="no-gutters">
            <Col xs="8">
              <HeaderField label="Plan #:" labelWidth={'3'} contentWidth="9">
                {planNumbers.join(', ')}
              </HeaderField>
            </Col>
            <Col>
              <HeaderField
                label="Land parcel type:"
                contentWidth="5"
                className="justify-content-end"
              >
                {props.composedProperty.apiWrapper?.response?.propertyType?.description}
              </HeaderField>
            </Col>
          </Row>
        </Col>
        <Col xs="auto" className="d-flex p-0 align-items-center justify-content-end">
          <TooltipWrapper toolTipId="property-zoom-map" toolTip="Zoom Map">
            <StyledIconButton
              variant="info"
              disabled={!props.onZoom}
              title="Zoom Map"
              onClick={() =>
                props?.onZoom && props?.onZoom(props.composedProperty.apiWrapper?.response)
              }
            >
              <FaSearchPlus size={22} />
            </StyledIconButton>
          </TooltipWrapper>
        </Col>
      </Row>
      <StyledDivider />
    </>
  );
};

const StyledDivider = styled.div`
  margin-top: 0.5rem;
  border-bottom-style: solid;
  border-bottom-color: grey;
  border-bottom-width: 0.1rem;
`;