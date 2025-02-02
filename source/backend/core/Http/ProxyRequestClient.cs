using System;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;

namespace Pims.Core.Http
{
    public class ProxyRequestClient : IProxyRequestClient
    {
        #region Properties

        /// <summary>
        /// get/set - The HttpClient use to make requests.
        /// </summary>
        protected HttpClient Client { get; }
        #endregion

        #region Constructors

        /// <summary>
        /// Creates a new instance of a ProxyRequestClient class, initializes it with the specified arguments.
        /// </summary>
        /// <param name="clientFactory"></param>
        public ProxyRequestClient(IHttpClientFactory clientFactory)
        {
            this.Client = clientFactory.CreateClient();
        }
        #endregion

        #region Methods

        /// <summary>
        /// Dispose managed resources.
        /// </summary>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        #region Proxy Methods

        /// <summary>
        /// Proxy the request on behalf of the original requestor to the specified 'url'.
        /// </summary>
        /// <param name="request"></param>
        /// <param name="url"></param>
        /// <param name="method"></param>
        /// <param name="content"></param>
        /// <returns></returns>
        public virtual Task<HttpResponseMessage> ProxySendAsync(HttpRequest request, string url, HttpMethod method = null, HttpContent content = null)
        {
            ArgumentNullException.ThrowIfNull(request, nameof(request));
            if (string.IsNullOrWhiteSpace(url)) { throw new ArgumentException($"Argument '{nameof(url)}' must be a valid URL."); }

            return this.ProxySendInternalAsync(request, url, method, content);
        }

        /// <summary>
        /// Proxy a GET request to the specified 'url'.
        /// This will use the original requests Authorization token in the server request.
        /// </summary>
        /// <param name="request"></param>
        /// <param name="url"></param>
        /// <returns></returns>
        public async Task<HttpResponseMessage> ProxyGetAsync(HttpRequest request, string url)
        {
            return await ProxySendAsync(request, url, HttpMethod.Get);
        }

        /// <summary>
        /// Proxy a POST request to the specified 'url'.
        /// This will use the original requests Authorization token in the server request.
        /// </summary>
        /// <param name="request"></param>
        /// <param name="url"></param>
        /// <returns></returns>
        public async Task<HttpResponseMessage> ProxyPostAsync(HttpRequest request, string url, HttpContent content = null)
        {
            return await ProxySendAsync(request, url, HttpMethod.Post, content);
        }

        /// <summary>
        /// Proxy a PUT request to the specified 'url'.
        /// This will use the original requests Authorization token in the server request.
        /// </summary>
        /// <param name="request"></param>
        /// <param name="url"></param>
        /// <returns></returns>
        public async Task<HttpResponseMessage> ProxyPutAsync(HttpRequest request, string url, HttpContent content = null)
        {
            return await ProxySendAsync(request, url, HttpMethod.Put, content);
        }

        /// <summary>
        /// Proxy a DELETE request to the specified 'url'.
        /// This will use the original requests Authorization token in the server request.
        /// </summary>
        /// <param name="request"></param>
        /// <param name="url"></param>
        /// <returns></returns>
        public async Task<HttpResponseMessage> ProxyDeleteAsync(HttpRequest request, string url, HttpContent content = null)
        {
            return await ProxySendAsync(request, url, HttpMethod.Delete, content);
        }

        /// <summary>
        /// Dispose the HttpClient.
        /// </summary>
        protected virtual void Dispose(bool disposing)
        {
            if (disposing)
            {
                // free managed resources
                this.Client.Dispose();
            }
        }

        /// <summary>
        /// Proxy the request on behalf of the original requestor to the specified 'url'.
        /// Note: Internal implementation to avoid throw on different threads.
        /// </summary>
        /// <param name="request"></param>
        /// <param name="url"></param>
        /// <param name="method"></param>
        /// <param name="content"></param>
        /// <returns></returns>
        private Task<HttpResponseMessage> ProxySendInternalAsync(HttpRequest request, string url, HttpMethod method = null, HttpContent content = null)
        {
            // Extract the original requests authorization token.
            if (method == null)
            {
                method = HttpMethod.Get;
            }

            using var message = new HttpRequestMessage(method, url);
            var token = request.Headers["Authorization"];
            if (!string.IsNullOrWhiteSpace(token))
            {
                message.Headers.Add("Authorization", token.ToString());
            }

            message.Headers.Add("X-Forwarded-For", request.Host.Value);
            message.Headers.Add("X-Forwarded-Proto", request.Scheme);
            message.Headers.Add("ProxyPreserveHost", "On");
            message.Headers.Add("User-Agent", "Pims.Api");
            message.Content = content;

            return this.Client.SendAsync(message);
        }
        #endregion
        #endregion
    }
}
