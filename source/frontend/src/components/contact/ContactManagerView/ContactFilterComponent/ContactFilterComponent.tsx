import { Form, Formik } from 'formik';
import React from 'react';
import { Col, Row } from 'react-bootstrap';
import { FaRegBuilding, FaRegUser } from 'react-icons/fa';
import styled from 'styled-components';

import ActiveIndicator from '@/components/common/ActiveIndicator';
import { ResetButton, SearchButton } from '@/components/common/buttons';
import ActiveFilterCheck from '@/components/common/form/ActiveFilterCheck';
import { RadioGroup } from '@/components/common/form/RadioGroup';
import { InlineInput } from '@/components/common/form/styles';
import { ColButtons, FlexRowNoGap } from '@/components/common/styles';
import { IContactFilter } from '@/components/contact/ContactManagerView/IContactFilter';

export const defaultFilter: IContactFilter = {
  summary: '',
  municipality: '',
  searchBy: 'all',
  activeContactsOnly: true,
};

export enum RestrictContactType {
  ONLY_INDIVIDUALS = 'persons',
  ONLY_ORGANIZATIONS = 'organizations',
  ALL = 'all',
}

export interface IContactFilterComponentProps {
  filter?: IContactFilter;
  setFilter: (filter: IContactFilter) => void;
  showActiveSelector?: boolean;
  restrictContactType?: RestrictContactType;
}

/**
 * Filter bar for contact list.
 * @param {IContactFilterComponentProps} param0
 */
export const ContactFilterComponent: React.FunctionComponent<
  React.PropsWithChildren<IContactFilterComponentProps>
> = ({
  filter,
  setFilter,
  showActiveSelector,
  restrictContactType,
}: IContactFilterComponentProps) => {
  const resetFilter = (values: IContactFilter) => {
    setFilter({ ...defaultFilter, searchBy: values.searchBy });
  };

  return (
    <Formik
      enableReinitialize
      initialValues={
        filter ?? {
          ...defaultFilter,
          searchBy: restrictContactType?.toString() ?? RestrictContactType.ALL,
        }
      }
      onSubmit={(values, { setSubmitting }) => {
        setFilter(values);
        setSubmitting(false);
      }}
      validateOnChange={true}
    >
      {({ resetForm, isSubmitting, values, submitForm }) => (
        <StyledFilterBoxForm
          onKeyUp={(e: any) => {
            if (e.keyCode === 13) {
              submitForm();
            }
          }}
        >
          <Row className="p-5">
            <Col lg="6">
              <Row className="pb-5">
                <Col xs="auto">
                  <RadioGroup
                    label="Search by:"
                    field="searchBy"
                    radioGroupClassName="pb-3"
                    radioValues={getRestrictedRadioValues(restrictContactType)}
                  />
                </Col>
                <Col lg="auto" className="pl-0">
                  <StyledNameInput field="summary" placeholder="Name" />
                </Col>
              </Row>
            </Col>
            <Col lg="5">
              <Row>
                <Col className="pl-0">
                  <StyledCityInput
                    field="municipality"
                    label="City"
                    placeholder="City of contact's address"
                  />
                </Col>
                <Col className="pl-4">
                  {showActiveSelector && (
                    <FlexRowNoGap>
                      <ActiveFilterCheck<IContactFilter>
                        fieldName="activeContactsOnly"
                        setFilter={setFilter}
                      />
                      <ActiveIndicator active size={16} />
                      <span className="ml-1">
                        <b>Active</b> contacts only
                      </span>
                    </FlexRowNoGap>
                  )}
                </Col>
              </Row>
            </Col>
            <ColButtons lg="1">
              <Row>
                <Col lg="auto" className="pr-0">
                  <SearchButton
                    disabled={isSubmitting}
                    onClick={() => {
                      submitForm();
                    }}
                  />
                </Col>
                <Col lg="auto">
                  <ResetButton
                    disabled={isSubmitting}
                    onClick={() => {
                      resetForm({ values: { ...defaultFilter, searchBy: values.searchBy } });
                      resetFilter(values);
                    }}
                  />
                </Col>
              </Row>
            </ColButtons>
          </Row>
        </StyledFilterBoxForm>
      )}
    </Formik>
  );
};

const getRestrictedRadioValues = (restrictContactType?: RestrictContactType) => {
  if (restrictContactType === RestrictContactType.ONLY_INDIVIDUALS) {
    return [
      {
        radioLabel: (
          <>
            <FaRegUser size={20} />
            <span>Individuals</span>
          </>
        ),
        radioValue: 'persons',
      },
    ];
  } else if (restrictContactType === RestrictContactType.ONLY_ORGANIZATIONS) {
    return [
      {
        radioLabel: (
          <>
            <FaRegUser size={20} />
            <span>Organizations</span>
          </>
        ),
        radioValue: 'organizations',
      },
    ];
  } else {
    return [
      {
        radioLabel: (
          <>
            <FaRegBuilding size={20} />
            <span>Organizations</span>
          </>
        ),
        radioValue: 'organizations',
      },
      {
        radioLabel: (
          <>
            <FaRegUser size={20} />
            <span>Individuals</span>
          </>
        ),
        radioValue: 'persons',
      },
      {
        radioLabel: (
          <>
            <FaRegBuilding size={20} />+<FaRegUser size={20} />
            <span>All</span>
          </>
        ),
        radioValue: 'all',
      },
    ];
  }
};

const StyledFilterBoxForm = styled(Form)`
  background-color: ${({ theme }) => theme.css.filterBoxColor};
  border-radius: 0.4rem;
  padding: 1rem;
  max-width: 85%;
`;

export const StyledNameInput = styled(InlineInput)`
  max-width: 30em;
`;

export const StyledCityInput = styled(InlineInput)`
  max-width: 25rem;
`;
