import React from 'react';
import ReactDOM from 'react-dom';
import { Card, CardBody, CardHeader, Row, Col, Button } from 'reactstrap';

import api from '../api';

// Renders the details of an individual task as a card
export default function Task(props) {
  let task = props.task;

  // Sends a request to delete the task
  function delete_task() {
    api.delete_task(task.id);
  }

  // Displays the edit form, and populates the task id hidden field
  function edit_task() {
    $("#edit-form").show();
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
            <p><b>Assignee: </b>{task.user.name}</p>
            <p><b>Completed: </b>{task.completed ? "Yes" : "No"}</p>
            <p><b>Minutes Spent: </b>{task.time_spent}</p>
            <p><b>Description: </b>{task.description}</p>
          </div>
        </CardBody>
      </Card>
    </Col>
  );
}
