using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using FluentAssertions;
using Moq;
using NetTopologySuite.Geometries;
using Pims.Api.Constants;
using Pims.Api.Models.CodeTypes;
using Pims.Api.Services;
using Pims.Core.Api.Exceptions;
using Pims.Core.Exceptions;
using Pims.Core.Security;
using Pims.Core.Test;
using Pims.Dal.Entities;
using Pims.Dal.Entities.Models;
using Pims.Dal.Exceptions;
using Pims.Dal.Repositories;
using Xunit;

namespace Pims.Api.Test.Services
{
    [Trait("category", "unit")]
    [Trait("category", "api")]
    [Trait("group", "management")]
    [ExcludeFromCodeCoverage]
    public class ManagementActivityServiceTest
    {
        private readonly TestHelper _helper;

        public ManagementActivityServiceTest()
        {
            this._helper = new TestHelper();
        }

        private ManagementActivityService CreateManagementServiceWithPermissions(params Permissions[] permissions)
        {
            var user = PrincipalHelper.CreateForPermission(permissions);
            return this._helper.Create<ManagementActivityService>(user);
        }

        #region GetPage
        [Fact]
        public void GetPage_Success()
        {
            // Arrange
            var service = this.CreateManagementServiceWithPermissions(Permissions.ManagementView);

            var managementActivity = EntityHelper.CreateManagementActivity(1);

            var repository = this._helper.GetService<Mock<IManagementActivityRepository>>();
            repository.Setup(x => x.GetPageDeep(It.IsAny<ManagementActivityFilter>())).Returns(new Paged<PimsManagementActivity>(new[] { managementActivity }));

            // Act
            var result = service.GetPage(new ManagementActivityFilter());

            // Assert
            repository.Verify(x => x.GetPageDeep(It.IsAny<ManagementActivityFilter>()), Times.Once);
        }

        [Fact]
        public void GetPage_NoPermission()
        {
            // Arrange
            var service = this.CreateManagementServiceWithPermissions();

            var managementActivity = EntityHelper.CreateManagementActivity(1);

            // Act
            Action act = () => service.GetPage(new ManagementActivityFilter());

            // Assert
            act.Should().Throw<NotAuthorizedException>();
        }
        #endregion

        #region Reports
        [Fact]
        public void SearchManagementActivities_Success()
        {
            // Arrange
            var service = this.CreateManagementServiceWithPermissions(Permissions.ManagementView);

            var managementActivity = EntityHelper.CreateManagementActivity(1);

            var repository = this._helper.GetService<Mock<IManagementActivityRepository>>();
            repository.Setup(x => x.SearchManagementActivities(It.IsAny<ManagementActivityFilter>())).Returns(new Collection<PimsManagementActivity>(new[] { managementActivity }));

            // Act
            var result = service.SearchManagementActivities(new ManagementActivityFilter());

            // Assert
            repository.Verify(x => x.SearchManagementActivities(It.IsAny<ManagementActivityFilter>()), Times.Once);
        }

        [Fact]
        public void SearchManagementActivities_NoPermission()
        {
            // Arrange
            var service = this.CreateManagementServiceWithPermissions();

            var managementActivity = EntityHelper.CreateManagementActivity(1);

            // Act
            Action act = () => service.SearchManagementActivities(new ManagementActivityFilter());

            // Assert
            act.Should().Throw<NotAuthorizedException>();
        }

        [Fact]
        public void SearchManagementActivityInvoices_Success()
        {
            // Arrange
            var service = this.CreateManagementServiceWithPermissions(Permissions.ManagementView);

            var activityInvoice = EntityHelper.CreateManagementActivityInvoice(1);

            var repository = this._helper.GetService<Mock<IManagementActivityRepository>>();
            repository.Setup(x => x.SearchManagementActivityInvoices(It.IsAny<ManagementActivityFilter>())).Returns(new Collection<PimsManagementActivityInvoice>(new[] { activityInvoice }));

            // Act
            var result = service.SearchManagementActivityInvoices(new ManagementActivityFilter());

            // Assert
            repository.Verify(x => x.SearchManagementActivityInvoices(It.IsAny<ManagementActivityFilter>()), Times.Once);
        }

        [Fact]
        public void SearchManagementActivityInvoices_NoPermission()
        {
            // Arrange
            var service = this.CreateManagementServiceWithPermissions();

            var activityInvoice = EntityHelper.CreateManagementActivityInvoice(1);

            // Act
            Action act = () => service.SearchManagementActivityInvoices(new ManagementActivityFilter());

            // Assert
            act.Should().Throw<NotAuthorizedException>();
        }
        #endregion
    }
}
