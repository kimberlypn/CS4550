import React from 'react';
import ReactDOM from 'react-dom';
import { connect } from 'react-redux';
import { Card, CardBody, CardHeader, Row, Col, Button } from 'reactstrap';

import api from '../api';

// Renders the details of an individual task as a card
function Task(props) {
  let task = props.task;
  // Decide whether to display the assignee or the assigner
  let assign = props.type == "self" ?
    <p><b>Assigned By: </b>{task.creator.name} (ID: {task.creator.id})</p>
      : <p><b>Assigned To: </b>{task.user.name} (ID: {task.user.id})</p>

  // Sends a request to delete the task
  function delete_task() {
    api.delete_task(task.id);
  }

  // Displays the edit form, populates the hidden field with the task id, and
  // clears all other fields
  function edit_task() {
    $("#edit-form").show();
      props.dispatch({
        type: 'CLEAR_FORM',
      });
    $('input[name="id"]').val(task.id);
  }

  // Returns the task details as a Bootstrap card element
  return (
    <Col md="6">
      <Card>
        <CardHeader>
          <Row>
            <Col md="7">
              {task.title}
            </Col>
            <Col md="5">
              <Button type="button" onClick={edit_task}>Edit</Button>
              <Button type="button" onClick={delete_task}>Delete</Button>
            </Col>
          </Row>
        </CardHeader>
        <CardBody>
          <div>
            {assign}
            <p><b>Completed: </b>{task.completed ? "Yes" : "No"}</p>
            <p><b>Minutes Spent: </b>{task.time_spent}</p>
            <p><b>Description: </b>{task.description}</p>
          </div>
        </CardBody>
      </Card>
    </Col>
  );
}

function state2props(state) {
  return {
    form: state.form,
    users: state.users
  };
}

export default connect(state2props)(Task);
