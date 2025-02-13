using Pims.Core.Http.Models;
using Pims.Ltsa.Models;
using System.Threading.Tasks;

namespace Pims.Ltsa
{
    public interface ILtsaService
    {
        Task<TokenModel> GetTokenAsync(string integratorUsername = null, string integratorPassword = null, string myLtsaUsername = null, string myLtsaUserPassword = null);
        Task<TitleSummariesResponse> GetTitleSummariesAsync(int pid);
        Task<OrderWrapper<OrderParent<Title>>> PostTitleOrder(string titleNumber, string landTitleDistrictCode);
        Task<OrderWrapper<OrderParent<ParcelInfo>>> PostParcelInfoOrder(string pid);
        Task<OrderWrapper<OrderParent<StrataPlanCommonProperty>>> PostSpcpOrder(string strataPlanNumber);
        Task<LtsaOrders> PostLtsaFields(string pid);
    }
}
