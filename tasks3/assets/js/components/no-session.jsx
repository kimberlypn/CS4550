import React from 'react';
import { Row, Col } from 'reactstrap';

import RegistrationForm from './registration-form';

// Renders a message telling the user to log in
export default function NoSession(props) {
  // Toggles the registration form
  function register() {
    $("#registration-form").show();
    $("#no-session").hide();
  }

  return (
    <div>
      <Row>
        <Col md="2"></Col>
        <Col md="8">
          <RegistrationForm />
        </Col>
        <Col md="2"></Col>
      </Row>
      <div id="no-session">
        <p>
          Log in to see your tasks.<br />
          Don't have an account? Register <a href="javascript:void(0)"
          onClick={register}>here</a>.
        </p>
      </div>
    </div>
  );
}
