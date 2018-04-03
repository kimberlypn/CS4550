import React from 'react';
import { Card, CardBody } from 'reactstrap';

// Adapted from Nat's lecture notes
export default function Task(props) {
  let task = props.task;

  return (
    <Card>
      <CardBody>
        <div>
          <h3>{task.title}</h3>
          <p><b>Assignee: </b>{task.user.name}</p>
          <p><b>Completed: </b>{task.completed ? "Yes" : "No"}</p>
          <p><b>Minutes Spent: </b>{task.time_spent}</p>
          <p><b>Description: </b>{task.description}</p>
        </div>
      </CardBody>
    </Card>
  );
}
