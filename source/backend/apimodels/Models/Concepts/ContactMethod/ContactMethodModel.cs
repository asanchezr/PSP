using Pims.Api.Models.Base;

namespace Pims.Api.Models.Concepts.ContactMethod
{
    /// <summary>
    /// Provides a Contact method model.
    /// </summary>
    public class ContactMethodModel : BaseConcurrentModel
    {
        #region Properties

        /// <summary>
        /// get/set - The primary key to identify the contact method.
        /// </summary>
        public long Id { get; set; }

        /// <summary>
        /// get/set - The person owner of the contact.
        /// </summary>
        public long? PersonId { get; set; }

        /// <summary>
        /// get/set - The organization owner of the contact.
        /// </summary>
        public long? OrganizationId { get; set; }

        /// <summary>
        /// get/set - The contact method type.
        /// </summary>
        public CodeTypeModel<string> ContactMethodType { get; set; }

        /// <summary>
        /// get/set - The contact method value.
        /// </summary>
        public string Value { get; set; }
        #endregion
    }
}
