using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.CompilerServices;
using Microsoft.Extensions.Logging;

namespace Pims.Dal.Helpers.Extensions
{
    public static class LoggingExtensions
    {
        /// <summary>
        /// Use your own log scope. This will add additional property (scope) with scopeValue.
        /// </summary>
        /// <param name="logger">The ILogger.</param>
        /// <param name="scope">Scope property name.</param>
        /// <param name="scopeValue">Scope property value.</param>
        public static IDisposable LogScope<T>(this ILogger<T> logger, string scope, string scopeValue)
            => logger.BeginScope(new Dictionary<string, object> { { scope, scopeValue } });

        /// <summary>
        /// Use a query log scope to aid in debugging EF queries.
        /// It will add a "Query" property to all logs inside this scope with queryName as the value.
        /// </summary>
        /// <param name="logger">The ILogger.</param>
        /// <param name="queryName">Scope property value.</param>
        public static IDisposable QueryScope<T>(this ILogger<T> logger, string queryName)
            => LogScope(logger, "Query", queryName);

        /// <summary>
        /// Use a query log scope auto-generated based on the class and method name.
        /// It will add a "Query" property to all logs inside this scope with "Class-Method" as the value.
        /// </summary>
        /// <example>
        /// // This will do the following:
        /// // 1. Add property "Query" with value "TwitterService-GetTweets"
        /// public class TwitterService
        /// {
        ///     public Task<IEnumerable<Tweet>> GetTweets(CancellationToken ct)
        ///     {
        ///         using var _ = _logger.QueryScope();
        ///         return await _context.Tweets
        ///             .AsNoTracking()
        ///             .ToListAsync(ct);
        ///     }
        /// }
        /// </example>
        /// <param name="logger">The ILogger</param>
        /// <param name="callerFileName">Caller filename generated by the compiler.</param>
        /// <param name="callerName">Caller method name generated by the compiler</param>
        public static IDisposable QueryScope<T>(this ILogger<T> logger, [CallerFilePath] string callerFileName = "", [CallerMemberName] string callerName = "")
        {
            var logScopeName = GenerateLogScopeName(null, callerFileName, callerName);
            return QueryScope(logger, logScopeName);
        }

        public static string GenerateLogScopeNameFromContext(string message = null, [CallerFilePath] string callerFileName = "", [CallerMemberName] string callerName = "")
            => GenerateLogScopeName(message, callerFileName, callerName);

        public static string GenerateLogScopeName(string message = null, string callerFileName = "", string callerName = "")
        {
            if (!string.IsNullOrWhiteSpace(message))
            {
                message = "-" + message;
            }

            var className = Path.GetFileNameWithoutExtension(callerFileName);
            return className + "-" + callerName + message;
        }
    }
}