﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Pims.Dal.Entities;

/// <summary>
/// Defines the relationship between an acquisition file and a document.
/// </summary>
[Table("PIMS_ACQUISITION_FILE_DOCUMENT")]
[Index("AcquisitionFileId", Name = "ACQDOC_ACQUISITION_FILE_ID_IDX")]
[Index("DocumentId", Name = "ACQDOC_DOCUMENT_ID_IDX")]
[Index("DocumentId", "AcquisitionFileId", Name = "ACQNOT_ACQUISITION_FILE_DOCUMENT_TUC", IsUnique = true)]
public partial class PimsAcquisitionFileDocument
{
    [Key]
    [Column("ACQUISITION_FILE_DOCUMENT_ID")]
    public long AcquisitionFileDocumentId { get; set; }

    [Column("ACQUISITION_FILE_ID")]
    public long AcquisitionFileId { get; set; }

    [Column("DOCUMENT_ID")]
    public long DocumentId { get; set; }

    [Column("CONCURRENCY_CONTROL_NUMBER")]
    public long ConcurrencyControlNumber { get; set; }

    [Column("APP_CREATE_TIMESTAMP", TypeName = "datetime")]
    public DateTime AppCreateTimestamp { get; set; }

    [Required]
    [Column("APP_CREATE_USERID")]
    [StringLength(30)]
    public string AppCreateUserid { get; set; }

    [Column("APP_CREATE_USER_GUID")]
    public Guid? AppCreateUserGuid { get; set; }

    [Required]
    [Column("APP_CREATE_USER_DIRECTORY")]
    [StringLength(30)]
    public string AppCreateUserDirectory { get; set; }

    [Column("APP_LAST_UPDATE_TIMESTAMP", TypeName = "datetime")]
    public DateTime AppLastUpdateTimestamp { get; set; }

    [Required]
    [Column("APP_LAST_UPDATE_USERID")]
    [StringLength(30)]
    public string AppLastUpdateUserid { get; set; }

    [Column("APP_LAST_UPDATE_USER_GUID")]
    public Guid? AppLastUpdateUserGuid { get; set; }

    [Required]
    [Column("APP_LAST_UPDATE_USER_DIRECTORY")]
    [StringLength(30)]
    public string AppLastUpdateUserDirectory { get; set; }

    [Column("DB_CREATE_TIMESTAMP", TypeName = "datetime")]
    public DateTime DbCreateTimestamp { get; set; }

    [Required]
    [Column("DB_CREATE_USERID")]
    [StringLength(30)]
    public string DbCreateUserid { get; set; }

    [Column("DB_LAST_UPDATE_TIMESTAMP", TypeName = "datetime")]
    public DateTime DbLastUpdateTimestamp { get; set; }

    [Required]
    [Column("DB_LAST_UPDATE_USERID")]
    [StringLength(30)]
    public string DbLastUpdateUserid { get; set; }

    [ForeignKey("AcquisitionFileId")]
    [InverseProperty("PimsAcquisitionFileDocuments")]
    public virtual PimsAcquisitionFile AcquisitionFile { get; set; }

    [ForeignKey("DocumentId")]
    [InverseProperty("PimsAcquisitionFileDocuments")]
    public virtual PimsDocument Document { get; set; }
}
