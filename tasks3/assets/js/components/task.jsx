import React from 'react';
import ReactDOM from 'react-dom';
import { Card, CardBody, CardHeader, Row, Col, Button } from 'reactstrap';

import api from '../api';

// Adapted from Nat's lecture notes
export default function Task(props) {
  let task = props.task;

  function delete_task() {
    api.delete_task(task.id);
  }

  function edit_task() {
    $("#edit-form").toggle();
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
