using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Pims.Ltsa.Models
{
    public class BctfaOwnershipList
    {
        public IEnumerable<int> Pids { get; set; }
    }
}
