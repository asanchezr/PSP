using Mapster;
using Entity = Pims.Dal.Entities;

namespace Pims.Api.Models.Concepts.Property
{
    public class PropertyViewMap : IRegister
    {
        public void Register(TypeAdapterConfig config)
        {
            config.NewConfig<Entity.PimsPropertyLocationVw, PropertyViewModel>()
               .Map(dest => dest.Id, src => src.PropertyId)
               .Map(dest => dest.Pid, src => src.Pid)
.Map(dest => dest.PidPadded, src => src.PidPadded)
.Map(dest => dest.Pin, src => src.Pin)
.Map(dest => dest.PropertyTypeCode, src => src.PropertyTypeCode)
.Map(dest => dest.PropertyStatusTypeCode, src => src.PropertyStatusTypeCode)
.Map(dest => dest.PropertyDataSourceTypeCode, src => src.PropertyDataSourceTypeCode)
.Map(dest => dest.PropertyDataSourceEffectiveDate, src => src.PropertyDataSourceEffectiveDate)
.Map(dest => dest.PropertyClassificationTypeCode, src => src.PropertyClassificationTypeCode)
.Map(dest => dest.PropertyTenureTypeCode, src => src.PropertyTenureTypeCode)
.Map(dest => dest.StreetAddress1, src => src.StreetAddress1)
.Map(dest => dest.StreetAddress2, src => src.StreetAddress2)
.Map(dest => dest.StreetAddress3, src => src.StreetAddress3)
.Map(dest => dest.MunicipalityName, src => src.MunicipalityName)
.Map(dest => dest.PostalCode, src => src.PostalCode)
.Map(dest => dest.ProvinceStateCode, src => src.ProvinceStateCode)
.Map(dest => dest.ProvinceName, src => src.ProvinceName)
.Map(dest => dest.CountryCode, src => src.CountryCode)
.Map(dest => dest.CountryName, src => src.CountryName)
.Map(dest => dest.Name, src => src.Name)
.Map(dest => dest.Description, src => src.Description)
.Map(dest => dest.AddressId, src => src.AddressId)
.Map(dest => dest.RegionCode, src => src.RegionCode)
.Map(dest => dest.DistrictCode, src => src.DistrictCode)
.Map(dest => dest.PropertyAreaUnitTypeCode, src => src.PropertyAreaUnitTypeCode)
.Map(dest => dest.LandArea, src => src.LandArea)
.Map(dest => dest.LandLegalDescription, src => src.LandLegalDescription)
.Map(dest => dest.SurveyPlanNumber, src => src.SurveyPlanNumber)
.Map(dest => dest.EncumbranceReason, src => src.EncumbranceReason)
.Map(dest => dest.IsSensitive, src => src.IsSensitive)
.Map(dest => dest.IsOwned, src => src.IsOwned)
.Map(dest => dest.IsRetired, src => src.IsRetired)
.Map(dest => dest.IsVisibleToOtherAgencies, src => src.IsVisibleToOtherAgencies)
.Map(dest => dest.Zoning, src => src.Zoning)
.Map(dest => dest.ZoningPotential, src => src.ZoningPotential)
.Map(dest => dest.IsDisposed, src => src.IsDisposed)
.Map(dest => dest.IsOtherInterest, src => src.IsOtherInterest)
.Map(dest => dest.HasActiveAcquisitionFile, src => src.HasActiveAcquisitionFile)
.Map(dest => dest.HasActiveResearchFile, src => src.HasActiveResearchFile)
.Map(dest => dest.IsPayableLease, src => src.IsPayableLease)
.Map(dest => dest.IsActivePayableLease, src => src.IsActivePayableLease)
.Map(dest => dest.IsReceivableLease, src => src.IsReceivableLease)
.Map(dest => dest.IsActiveReceivableLease, src => src.IsActiveReceivableLease);

            config.NewConfig<PropertyViewModel, Entity.PimsPropertyLocationVw>()
                .Map(dest => dest.PropertyId, src => src.Id)
               .Map(dest => dest.Pid, src => src.Pid)
.Map(dest => dest.PidPadded, src => src.PidPadded)
.Map(dest => dest.Pin, src => src.Pin)
.Map(dest => dest.PropertyTypeCode, src => src.PropertyTypeCode)
.Map(dest => dest.PropertyStatusTypeCode, src => src.PropertyStatusTypeCode)
.Map(dest => dest.PropertyDataSourceTypeCode, src => src.PropertyDataSourceTypeCode)
.Map(dest => dest.PropertyDataSourceEffectiveDate, src => src.PropertyDataSourceEffectiveDate)
.Map(dest => dest.PropertyClassificationTypeCode, src => src.PropertyClassificationTypeCode)
.Map(dest => dest.PropertyTenureTypeCode, src => src.PropertyTenureTypeCode)
.Map(dest => dest.StreetAddress1, src => src.StreetAddress1)
.Map(dest => dest.StreetAddress2, src => src.StreetAddress2)
.Map(dest => dest.StreetAddress3, src => src.StreetAddress3)
.Map(dest => dest.MunicipalityName, src => src.MunicipalityName)
.Map(dest => dest.PostalCode, src => src.PostalCode)
.Map(dest => dest.ProvinceStateCode, src => src.ProvinceStateCode)
.Map(dest => dest.ProvinceName, src => src.ProvinceName)
.Map(dest => dest.CountryCode, src => src.CountryCode)
.Map(dest => dest.CountryName, src => src.CountryName)
.Map(dest => dest.Name, src => src.Name)
.Map(dest => dest.Description, src => src.Description)
.Map(dest => dest.AddressId, src => src.AddressId)
.Map(dest => dest.RegionCode, src => src.RegionCode)
.Map(dest => dest.DistrictCode, src => src.DistrictCode)
.Map(dest => dest.PropertyAreaUnitTypeCode, src => src.PropertyAreaUnitTypeCode)
.Map(dest => dest.LandArea, src => src.LandArea)
.Map(dest => dest.LandLegalDescription, src => src.LandLegalDescription)
.Map(dest => dest.SurveyPlanNumber, src => src.SurveyPlanNumber)
.Map(dest => dest.EncumbranceReason, src => src.EncumbranceReason)
.Map(dest => dest.IsSensitive, src => src.IsSensitive)
.Map(dest => dest.IsOwned, src => src.IsOwned)
.Map(dest => dest.IsRetired, src => src.IsRetired)
.Map(dest => dest.IsVisibleToOtherAgencies, src => src.IsVisibleToOtherAgencies)
.Map(dest => dest.Zoning, src => src.Zoning)
.Map(dest => dest.ZoningPotential, src => src.ZoningPotential)
.Map(dest => dest.IsDisposed, src => src.IsDisposed)
.Map(dest => dest.IsOtherInterest, src => src.IsOtherInterest)
.Map(dest => dest.HasActiveAcquisitionFile, src => src.HasActiveAcquisitionFile)
.Map(dest => dest.HasActiveResearchFile, src => src.HasActiveResearchFile)
.Map(dest => dest.IsPayableLease, src => src.IsPayableLease)
.Map(dest => dest.IsActivePayableLease, src => src.IsActivePayableLease)
.Map(dest => dest.IsReceivableLease, src => src.IsReceivableLease)
.Map(dest => dest.IsActiveReceivableLease, src => src.IsActiveReceivableLease);
        }
    }
}