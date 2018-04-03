import React from 'react';
import { BrowserRouter as Router, Route } from 'react-router-dom';

import Dashboard from './dashboard';
import NewTaskForm from './new-task-form';

// Renders the dashboard and new task form
export default function Main(props) {
  return (
    <div>
      <Route path="/" exact={true} render={() =>
        <Dashboard tasks={props.tasks} user={props.user} />
      } />
      <Route path="/tasks" exact={true} render={() =>
        <NewTaskForm />
      } />
    </div>
  );
}
