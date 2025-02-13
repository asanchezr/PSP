using System.Reflection;
using Microsoft.AspNetCore.Hosting;

namespace Pims.Api.Models.Health
{
    /// <summary>
    /// EnvModel class, provides a model to represent a user.
    /// </summary>
    public class EnvModel
    {
        #region Properties

        /// <summary>
        /// get/set - The environment name.
        /// </summary>
        public string Environment { get; set; }

        /// <summary>
        /// get/set - The version.
        /// </summary>
        public string Version { get; set; }

        /// <summary>
        /// get/set - The file version.
        /// </summary>
        public string FileVersion { get; set; }

        /// <summary>
        /// get/set - The information version.
        /// </summary>
        public string InformationalVersion { get; set; }

        /// <summary>
        /// get/set - The DB version.
        /// </summary>
        public string DBVersion { get; set; }
        #endregion

        #region Constructors

        /// <summary>
        /// Creates a new instance of a EnvModel object.
        /// </summary>
        public EnvModel()
        {
        }

        /// <summary>
        /// Creates a new instance of a EnvModel object, initializes it with specified arguments.
        /// </summary>
        /// <param name="environment"></param>
        public EnvModel(IWebHostEnvironment environment)
        {
            this.Environment = environment.EnvironmentName;
            this.Version = this.GetType().Assembly.GetName().Version.ToString();
            this.FileVersion = Assembly.GetEntryAssembly().GetCustomAttribute<AssemblyFileVersionAttribute>().Version;
            this.InformationalVersion = Assembly.GetEntryAssembly().GetCustomAttribute<AssemblyInformationalVersionAttribute>().InformationalVersion;
            this.InformationalVersion = this.InformationalVersion.Contains('+') ? this.InformationalVersion.Remove(this.InformationalVersion.IndexOf('+')) : this.InformationalVersion;
        }
        #endregion
    }
}
