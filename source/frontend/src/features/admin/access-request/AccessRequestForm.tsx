import { Formik } from 'formik';
import { ButtonToolbar, Col, Row } from 'react-bootstrap';
import { FaInfoCircle } from 'react-icons/fa';
import styled from 'styled-components';

import { Button } from '@/components/common/buttons';
import { Form, Input, Select, TextArea } from '@/components/common/form';
import { RadioGroup } from '@/components/common/form/RadioGroup';
import { SectionField } from '@/components/common/Section/SectionField';
import TooltipWrapper from '@/components/common/TooltipWrapper';
import * as API from '@/constants/API';
import { DISCLAIMER_URL, PRIVACY_POLICY_URL } from '@/constants/strings';
import { useLookupCodeHelpers } from '@/hooks/useLookupCodeHelpers';
import { ApiGen_Concepts_AccessRequest } from '@/models/api/generated/ApiGen_Concepts_AccessRequest';
import { mapLookupCode } from '@/utils';
import { AccessRequestSchema } from '@/utils/YupSchema';

import { FormAccessRequest as AccessRequestFormModel, userTypeCodeValues } from './models';
import RolesToolTip from './RolesToolTip';

interface IAccessRequestFormProps {
  initialValues: AccessRequestFormModel;
  addAccessRequest: (
    accessRequest: ApiGen_Concepts_AccessRequest,
  ) => Promise<ApiGen_Concepts_AccessRequest | undefined>;
  onCancel?: () => void;
}

export const AccessRequestForm: React.FunctionComponent<
  React.PropsWithChildren<IAccessRequestFormProps>
> = ({ initialValues, addAccessRequest, onCancel }) => {
  const { getPublicByType, getOptionsByType } = useLookupCodeHelpers();
  const roles = getPublicByType(API.ROLE_TYPES);
  const selectRegions = getOptionsByType(API.REGION_TYPES).filter(
    region => region.label !== 'Cannot determine',
  );
  const selectRoles = roles.map(c => mapLookupCode(c, initialValues?.roleId));

  return (
    <Formik<AccessRequestFormModel>
      enableReinitialize={true}
      initialValues={initialValues}
      validationSchema={AccessRequestSchema}
      onSubmit={async (values, { setSubmitting }) => {
        try {
          await addAccessRequest(values.toApi());
        } finally {
          setSubmitting(false);
        }
      }}
    >
      <Form className="userInfo">
        <SectionField label="IDIR/BCeID" labelWidth={{ xs: 2 }}>
          <Input
            field="businessIdentifierValue"
            placeholder={initialValues?.businessIdentifierValue}
            readOnly={true}
            type="text"
          />
        </SectionField>

        <SectionField label="First name" labelWidth={{ xs: 2 }}>
          <Input
            field="firstName"
            placeholder={initialValues?.firstName}
            readOnly={true}
            type="text"
          />
        </SectionField>
        <SectionField label="Last name" labelWidth={{ xs: 2 }}>
          <Input field="surname" placeholder={initialValues?.surname} readOnly={true} type="text" />
        </SectionField>
        <SectionField label="Email" labelWidth={{ xs: 2 }}>
          <Input field="email" placeholder={initialValues?.email} readOnly={true} type="email" />
        </SectionField>
        <SectionField label="Position" labelWidth={{ xs: 2 }}>
          <Input
            field="position"
            placeholder="e.g. Property Analyst, Integrated Transportation & Infrastructure Services"
            type="text"
          />
        </SectionField>
        <SectionField
          label="Internal staff / Contractor"
          labelWidth={{ xs: 2 }}
          className="mb-4"
          required
        >
          <RadioGroup
            field="userTypeCode"
            radioValues={userTypeCodeValues}
            flexDirection="row"
          ></RadioGroup>
        </SectionField>
        <SectionField label="Role" labelWidth={{ xs: 2 }} required>
          <Select field="roleId" options={selectRoles} placeholder="Select..." />
          <TooltipWrapper
            tooltipId="role description tooltip icon"
            tooltip={<RolesToolTip />}
            placement="auto"
            className="tooltip-light"
          >
            <StyledTooltipIcon className="tooltip-icon" />
          </TooltipWrapper>
        </SectionField>
        <SectionField label="MoTI Region" labelWidth={{ xs: 2 }} required>
          <Select field="regionCodeId" options={selectRegions} placeholder="Select MoTI Region" />
        </SectionField>
        <SectionField label="Comments" labelWidth={{ xs: 2 }}>
          <TextArea
            field="note"
            placeholder="Please specify why you need access to PIMS and include your manager's name."
          />
        </SectionField>
        <Row className="pb-2">
          <Col xs={2}></Col>
          <Col>
            <p>
              By clicking &quot;Submit&quot; to request access, you agree to our{' '}
              <a target="_blank" rel="noopener noreferrer" href={DISCLAIMER_URL}>
                Terms and Conditions
              </a>{' '}
              and that you have read our{' '}
              <a target="_blank" rel="noopener noreferrer" href={PRIVACY_POLICY_URL}>
                Privacy Policy
              </a>
              .
            </p>
          </Col>
        </Row>
        <Row className="justify-content-md-center">
          <ButtonToolbar className="cancelSave">
            {onCancel ? (
              <Button className="mr-2" type="button" onClick={onCancel}>
                Cancel
              </Button>
            ) : null}
            <Button type="submit">{!initialValues?.id ? 'Submit' : 'Update'}</Button>
          </ButtonToolbar>
        </Row>
      </Form>
    </Formik>
  );
};

const StyledTooltipIcon = styled(FaInfoCircle)`
  position: absolute;
  top: 1rem;
  right: -0.5rem;
`;

export default AccessRequestForm;
