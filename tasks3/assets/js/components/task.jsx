import React from 'react';
import ReactDOM from 'react-dom';
import { Card, CardBody, CardHeader, Row, Col, Button } from 'reactstrap';

// Adapted from Nat's lecture notes
export default function Task(props) {
  let task = props.task;

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
              <Button type="button" class="btn btn-primary">Edit</Button>
              <Button type="button" class="btn btn-danger">Delete</Button>
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
