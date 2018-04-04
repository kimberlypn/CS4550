import React from 'react';
import { connect } from 'react-redux';
import { Button, FormGroup, Label, Input } from 'reactstrap';

import api from '../api';

// Renders the registration form
function RegistrationForm(props) {
  // Updates the state with the inputted values from the registration form
  function update(ev) {
    let tgt = $(ev.target);
    let data = {};
    data[tgt.attr('name')] = tgt.val();
    let action = {
      type: 'UPDATE_REGISTRATION_FORM',
      data: data
    };
    props.dispatch(action);
  }

  // Sends a request to create a user with the values from the forms
  function submit(ev) {
    api.create_user(props.form);
  }

  // Clears all of the fields and closes the form
  function cancel() {
    props.dispatch({
      type: 'CLEAR_FORM',
    });
    $("#registration-form").hide();
    $("#no-session").show();
  }

  return (
    <div id="registration-form" style={{padding: "4ex"}}>
      <h2>Register Account</h2>
      <FormGroup>
        <Label for="email">Email</Label>
        <Input type="email" name="email" value={props.form.email}
          onChange={update} placeholder="user@example.com" />
      </FormGroup>
      <FormGroup>
        <Label for="name">Name</Label>
        <Input type="text" name="name" value={props.form.name}
          onChange={update} />
      </FormGroup>
      <FormGroup>
        <Label for="password">Password (must be at least 8 characters)</Label>
        <Input type="password" name="password" value={props.form.password}
          onChange={update} />
      </FormGroup>
      <Button onClick={submit} color="primary">Submit</Button>
      <Button onClick={cancel} color="primary">Cancel</Button>
    </div>
  );
};

function state2props(state) {
  console.log("STATE");
  console.log(state);
  return {
    form: state.register
  };
}

export default connect(state2props)(RegistrationForm);
