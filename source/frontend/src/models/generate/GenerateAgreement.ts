import { Api_Agreement } from 'models/api/Agreement';
import moment from 'moment';
import { formatMoney } from 'utils';

import { Api_GenerateFile } from './GenerateFile';
export class Api_GenerateAgreement {
  file: Api_GenerateFile;
  current_year: string;
  date: string;
  completion_date: string;
  termination_date: string;
  commencement_date: string;
  status: string;
  deposit_amount: string;
  purchase_price: string;
  survey_plan_number: string;
  no_later_than_days: string;

  constructor(agreement: Api_Agreement, generateFile: Api_GenerateFile) {
    this.file = generateFile;
    this.current_year = moment().format('YYYY');
    this.date = moment(agreement.agreementDate).format('MMM DD, YYYY') ?? '';
    this.status = agreement.isDraft ? 'DRAFT' : '';
    this.completion_date = moment(agreement.completionDate).format('MMM DD, YYYY') ?? '';
    this.termination_date = moment(agreement.terminationDate).format('MMM DD, YYYY') ?? '';
    this.commencement_date = moment(agreement.commencementDate).format('MMM DD, YYYY') ?? '';
    this.deposit_amount = formatMoney(agreement.depositAmount);
    this.purchase_price = formatMoney(agreement.purchasePrice);
    this.survey_plan_number = agreement.legalSurveyPlanNum ?? '';
    this.no_later_than_days = agreement.noLaterThanDays?.toString() ?? '';
  }
}