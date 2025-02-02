﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Pims.Dal.Entities;

/// <summary>
/// Defines the relationship betwwen a research file and a note.
/// </summary>
[Table("PIMS_RESEARCH_FILE_NOTE")]
[Index("NoteId", Name = "RFLNOT_NOTE_ID_IDX")]
[Index("ResearchFileId", Name = "RFLNOT_RESEARCH_FILE_ID_IDX")]
[Index("NoteId", "ResearchFileId", Name = "RFLNOT_RSRCH_FILE_NOTE_TUC", IsUnique = true)]
public partial class PimsResearchFileNote
{
    [Key]
    [Column("RESEARCH_FILE_NOTE_ID")]
    public long ResearchFileNoteId { get; set; }

    [Column("RESEARCH_FILE_ID")]
    public long ResearchFileId { get; set; }

    [Column("NOTE_ID")]
    public long NoteId { get; set; }

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

    [Column("DB_CREATE_USERID")]
    [StringLength(30)]
    public string DbCreateUserid { get; set; }

    [Column("DB_LAST_UPDATE_TIMESTAMP", TypeName = "datetime")]
    public DateTime DbLastUpdateTimestamp { get; set; }

    [Required]
    [Column("DB_LAST_UPDATE_USERID")]
    [StringLength(30)]
    public string DbLastUpdateUserid { get; set; }

    [ForeignKey("NoteId")]
    [InverseProperty("PimsResearchFileNotes")]
    public virtual PimsNote Note { get; set; }

    [ForeignKey("ResearchFileId")]
    [InverseProperty("PimsResearchFileNotes")]
    public virtual PimsResearchFile ResearchFile { get; set; }
}
