import Navbar from 'react-bootstrap/Navbar';
import styled from 'styled-components';

/**
 * Styled component provides consistent css for the page header.
 * Used by different layouts.
 * Displays the page header background, title, and logo.
 */
export const HeaderStyled = styled(Navbar)`
  padding: 0 1rem;
  min-height: 7rem;
  color: #ffffff;

  .longAppName {
    display: none;
  }
  .shortAppName {
    display: block;
  }

  .brand-box {
    padding: 1rem 0;
    align-items: center;
    flex-grow: 1;
  }

  .title {
    margin-left: 8px;
    display: inline-block;
    label {
      margin: 0;
      color: #ffffff;
      padding-left: 0px;
      text-align: center;
      font-size: 2.4rem;
      text-decoration: none solid rgb(255, 255, 255);
      font-family: 'BCSans', Fallback, sans-serif;
      font-weight: 700;
      white-space: normal;
    }
  }

  .other {
    flex-grow: 1;
    display: flex;
    flex-direction: row-reverse;
    align-items: center;
    padding: 0;
  }

  .modal-content .label {
    font-weight: 700;
  }

  // show long App Name when space allows
  @media (min-width: 99.2rem) {
    .longAppName {
      display: block;
      text-align: left;
      padding-left: 4rem;
    }
    .shortAppName {
      display: none;
    }
  }
`;

export default HeaderStyled;
