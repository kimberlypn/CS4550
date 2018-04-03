import React from 'react';
import Task from './task';
import { Row } from 'reactstrap';

// Adapted from Nat's lecture notes
export default function Dashboard(props) {
  let tasks = _.map(props.tasks, function(tt) {
    if (props.user == tt.user.id) {
      return <Task key={tt.id} task={tt} id={tt.id} />;
    }
  });

  return (
    <Row>
      {tasks}
    </Row>
  );
}
