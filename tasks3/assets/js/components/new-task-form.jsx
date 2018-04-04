import React from 'react';
import { connect } from 'react-redux';
import { Button, FormGroup, Label, Input } from 'reactstrap';

import api from '../api';

// Renders the new task form; adapted from Nat's lecture notes
function NewTaskForm(props) {
  // Updates the state with the inputted values from the new task form
  function update(ev) {
    let tgt = $(ev.target);
    let data = {};
    if (tgt.attr('name') == "completed") {
      data['completed'] = tgt.is(':checked') ? true : false;
    }
    else {
      data[tgt.attr('name')] = tgt.val();
    }
    let action = {
      type: 'UPDATE_FORM',
      data: data
    };
    props.dispatch(action);
  }

  // Sends a request to create a task with the values from the forms
  function submit(ev) {
    api.submit_task(props.form);
  }

  // Grabs all of the users to populate the dropdown
  let users = (_.map(props.users, (uu) =>
  <option key={uu.id} value={uu.id}>{uu.name}</option>));

  return (
    <div style={{padding: "4ex"}}>
      <h2>New Task</h2>
      <FormGroup>
        <Label for="user_id">Assignee</Label>
        <Input type="select" name="user_id" value={props.form.user_id}
          onChange={update}>
          {users}
        </Input>
      </FormGroup>
      <FormGroup>
        <Label for="title">Title</Label>
        <Input type="text" name="title" value={props.form.title}
          onChange={update} />
      </FormGroup>
      <FormGroup>
        <Label for="description">Description</Label>
        <Input type="textarea" name="description" value={props.form.description}
          onChange={update} />
      </FormGroup>
      <FormGroup>
        <Label for="time_spent">Minutes Spent (in increments of 15)</Label>
        <Input type="number" name="time_spent" step="15"
          value={props.form.time_spent} onChange={update} />
      </FormGroup>
      <FormGroup check>
        <Label check>
          <Input type="checkbox" name="completed" onChange={update}
            checked={props.form.completed ? "checked" : false} />
          Completed
        </Label>
      </FormGroup>
      <br />
      <Button onClick={submit} color="primary">Submit</Button>
    </div>
  );
};

function state2props(state) {
  return {
    form: state.form,
    users: state.users
  };
}

export default connect(state2props)(NewTaskForm);
