import React from 'react';
import Task from './task';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import { Row } from 'reactstrap';

import EditTaskForm from './edit-task-form';

// Adapted from Nat's lecture notes
export default function Dashboard(props) {
  // Only display tasks assigned to the user
  let tasks = _.map(props.tasks, function(tt) {
    if (props.user == tt.user.id) {
      return <Task key={tt.id} task={tt} id={tt.id} />;
    }
  });

  return (
    <div>
      <Route path="/" exact={true} render={() =>
        <EditTaskForm />
      } />
      <Row>{tasks}</Row>
    </div>
  );
}
