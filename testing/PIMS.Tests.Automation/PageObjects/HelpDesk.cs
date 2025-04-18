﻿using OpenQA.Selenium;

namespace PIMS.Tests.Automation.PageObjects
{
    public class HelpDesk : PageObjectBase
    {
        //Help Desk Main Button
        private By mainMenuHelpDeskBttn = By.CssSelector("header div[class='nav-item'] div");

        //Modal Header
        private By mainMenuHeader = By.XPath("//div[contains(text(),'Help Desk')]");

        //Modal Content
        private By helpDeskSubtitle = By.XPath("//h3[contains(text(),'Get started with PIMS')]");
        private By helpDeskDescription = By.XPath("//p[contains(text(),'This overview has useful tools that will support you to start using the application. You can also watch the video demos.')]");
        private By helpDeskPIMSResourcesLink = By.XPath("//a[contains(text(),'PIMS Training Materials')]");

        private By helpDeskContactUsSubtitle = By.XPath("//h3[contains(text(),'Contact us')]");
        private By helpDeskUserLabel = By.XPath("//label[contains(text(),'Name')]");
        private By helpDeskUserInput = By.Id("input-user");
        private By helpDeskEmailLabel = By.XPath("//label[contains(text(),'Email')]");
        private By helpDeskEmailInput = By.Id("input-email");
        private By helpDeskDescriptionLabel = By.XPath("//label[contains(text(),'Description')]");
        private By helpDeskDescriptionInput = By.Id("input-description");
        private By helpDeskFooterQuestion = By.XPath("//p[contains(text(),'Do you want to proceed and send the email?')]");

        //Help Desk Buttons Elements
        private By noButton = By.CssSelector("button[data-testid='cancel-modal-button']");
        private By yesButton = By.CssSelector("div[class='modal-footer'] a[data-testid='ok-modal-button']");

        public HelpDesk(IWebDriver webDriver) : base(webDriver)
        {}

        public void NavigateToHelpDesk()
        {
            Wait();
            FocusAndClick(mainMenuHelpDeskBttn);
        }

        public void VerifyHelpDeskModal()
        {
            WaitUntilVisible(mainMenuHeader);

            AssertTrueIsDisplayed(mainMenuHeader);

            AssertTrueIsDisplayed(helpDeskSubtitle);
            AssertTrueIsDisplayed(helpDeskDescription);
            AssertTrueIsDisplayed(helpDeskPIMSResourcesLink);

            AssertTrueIsDisplayed(helpDeskContactUsSubtitle);
            AssertTrueIsDisplayed(helpDeskUserLabel);
            AssertTrueIsDisplayed(helpDeskUserInput);
            AssertTrueIsDisplayed(helpDeskEmailLabel);
            AssertTrueIsDisplayed(helpDeskEmailInput);
            AssertTrueIsDisplayed(helpDeskDescriptionLabel);
            AssertTrueIsDisplayed(helpDeskDescriptionInput);
            AssertTrueIsDisplayed(helpDeskFooterQuestion);

            AssertTrueIsDisplayed(noButton);
            AssertTrueIsDisplayed(yesButton);
        }

        public void CancelHelpDeskModal()
        {
            WaitUntilClickable(noButton);
            webDriver.FindElement(noButton).Click();
        }
    }
}
