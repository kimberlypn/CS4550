import React from 'react';
import { Card, CardBody, CardHeader, Col } from 'reactstrap';

// Adapted from Nat's lecture notes
export default function Task(props) {
  let task = props.task;

  // Returns the task details as a Bootstrap card element
  return (
    <Col sm="6">
      <Card>
        <CardHeader>{task.title}</CardHeader>
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
