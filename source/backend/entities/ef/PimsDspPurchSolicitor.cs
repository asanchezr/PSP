﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Pims.Dal.Entities;

/// <summary>
/// Describes the solicitor associated with the sale of the disposition.  The solicitor may be an organizations or an individual.  If an organization is the solicitor, a primary contact person must be provided.
/// </summary>
[Table("PIMS_DSP_PURCH_SOLICITOR")]
[Index("DispositionSaleId", Name = "DSPPSL_DISPOSITION_SALE_ID_IDX")]
[Index("OrganizationId", Name = "DSPPSL_ORGANIZATION_ID_IDX")]
[Index("PersonId", Name = "DSPPSL_PERSON_ID_IDX")]
[Index("PrimaryContactId", Name = "DSPPSL_PRIMARY_CONTACT_ID_IDX")]
public partial class PimsDspPurchSolicitor
{
    /// <summary>
    /// Unique auto-generated surrogate primary key
    /// </summary>
    [Key]
    [Column("DSP_PURCH_SOLICITOR_ID")]
    public long DspPurchSolicitorId { get; set; }

    /// <summary>
    /// Foreign key of the dispostion sale.
    /// </summary>
    [Column("DISPOSITION_SALE_ID")]
    public long DispositionSaleId { get; set; }

    /// <summary>
    /// Foreign key of the individual solicitor for the disposition file.
    /// </summary>
    [Column("PERSON_ID")]
    public long? PersonId { get; set; }

    /// <summary>
    /// Foreign key of the organization solicitor for the disposition file.
    /// </summary>
    [Column("ORGANIZATION_ID")]
    public long? OrganizationId { get; set; }

    /// <summary>
    /// Primary contact person for the organization.
    /// </summary>
    [Column("PRIMARY_CONTACT_ID")]
    public long? PrimaryContactId { get; set; }

    /// <summary>
    /// Indicates if the code value is inactive.
    /// </summary>
    [Column("IS_DISABLED")]
    public bool? IsDisabled { get; set; }

    /// <summary>
    /// Application code is responsible for retrieving the row and then incrementing the value of the CONCURRENCY_CONTROL_NUMBER column by one prior to issuing an update.  If this is done then the update will succeed, provided that the row was not updated by any
    /// </summary>
    [Column("CONCURRENCY_CONTROL_NUMBER")]
    public long ConcurrencyControlNumber { get; set; }

    /// <summary>
    /// The date and time the record was created by the user.
    /// </summary>
    [Column("APP_CREATE_TIMESTAMP", TypeName = "datetime")]
    public DateTime AppCreateTimestamp { get; set; }

    /// <summary>
    /// The user that created the record.
    /// </summary>
    [Required]
    [Column("APP_CREATE_USERID")]
    [StringLength(30)]
    public string AppCreateUserid { get; set; }

    /// <summary>
    /// GUID of the user that created the record.
    /// </summary>
    [Column("APP_CREATE_USER_GUID")]
    public Guid? AppCreateUserGuid { get; set; }

    /// <summary>
    /// User directory of the user that created the record.
    /// </summary>
    [Required]
    [Column("APP_CREATE_USER_DIRECTORY")]
    [StringLength(30)]
    public string AppCreateUserDirectory { get; set; }

    /// <summary>
    /// The date and time the record was updated by the user.
    /// </summary>
    [Column("APP_LAST_UPDATE_TIMESTAMP", TypeName = "datetime")]
    public DateTime AppLastUpdateTimestamp { get; set; }

    /// <summary>
    /// The user that updated the record.
    /// </summary>
    [Required]
    [Column("APP_LAST_UPDATE_USERID")]
    [StringLength(30)]
    public string AppLastUpdateUserid { get; set; }

    /// <summary>
    /// GUID of the user that updated the record.
    /// </summary>
    [Column("APP_LAST_UPDATE_USER_GUID")]
    public Guid? AppLastUpdateUserGuid { get; set; }

    /// <summary>
    /// User directory of the user that updated the record.
    /// </summary>
    [Required]
    [Column("APP_LAST_UPDATE_USER_DIRECTORY")]
    [StringLength(30)]
    public string AppLastUpdateUserDirectory { get; set; }

    /// <summary>
    /// The date and time the record was created.
    /// </summary>
    [Column("DB_CREATE_TIMESTAMP", TypeName = "datetime")]
    public DateTime DbCreateTimestamp { get; set; }

    /// <summary>
    /// The user or proxy account that created the record.
    /// </summary>
    [Required]
    [Column("DB_CREATE_USERID")]
    [StringLength(30)]
    public string DbCreateUserid { get; set; }

    /// <summary>
    /// The date and time the record was created or last updated.
    /// </summary>
    [Column("DB_LAST_UPDATE_TIMESTAMP", TypeName = "datetime")]
    public DateTime DbLastUpdateTimestamp { get; set; }

    /// <summary>
    /// The user or proxy account that created or last updated the record.
    /// </summary>
    [Required]
    [Column("DB_LAST_UPDATE_USERID")]
    [StringLength(30)]
    public string DbLastUpdateUserid { get; set; }

    [ForeignKey("DispositionSaleId")]
    [InverseProperty("PimsDspPurchSolicitors")]
    public virtual PimsDispositionSale DispositionSale { get; set; }

    [ForeignKey("OrganizationId")]
    [InverseProperty("PimsDspPurchSolicitors")]
    public virtual PimsOrganization Organization { get; set; }

    [ForeignKey("PersonId")]
    [InverseProperty("PimsDspPurchSolicitorPeople")]
    public virtual PimsPerson Person { get; set; }

    [ForeignKey("PrimaryContactId")]
    [InverseProperty("PimsDspPurchSolicitorPrimaryContacts")]
    public virtual PimsPerson PrimaryContact { get; set; }
}