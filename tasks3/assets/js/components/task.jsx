import React from 'react';
import { Card, CardBody } from 'reactstrap';

// Adapted from Nat's lecture notes
export default function Task(params) {
  let task = params.task;
  return <Card>
    <CardBody>
      <div>
        <p>Posted by <b>{ post.user.name }</b></p>
        <p>{ post.body }</p>
      </div>
    </CardBody>
  </Card>;
}
