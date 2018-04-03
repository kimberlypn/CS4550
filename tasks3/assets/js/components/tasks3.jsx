import React from 'react';
import ReactDOM from 'react-dom';
import { Provider, connect } from 'react-redux';
import { BrowserRouter as Router, Route } from 'react-router-dom';

import Nav from './nav';
import Dashboard from './dashboard';
import TaskForm from './task-form';

// Adapted from Nat's lecture notes
export default function tasks3_init(store) {
  ReactDOM.render(
    <Provider store={store}>
      <Tasks3 state={store.getState()} />
    </Provider>,
    document.getElementById('root'),
  );
}

let Tasks3 = connect((state) => state)((props) => {
  // Choose what to render depending on whether or not the user is logged in
  var main;
  if (!props.form.token) {
    main = (
      <div id="no-session">
        <p>Log in to see your tasks.</p>
      </div>
    );
  }
  else {
    main = (
      <div>
        <Route path="/" exact={true} render={() =>
          <Dashboard tasks={props.tasks} user={props.form.user_id} />
        } />
        <Route path="/tasks" exact={true} render={() =>
          <TaskForm />
        } />
      </div>
    );
  }

  return (
    <Router>
      <div>
        <Nav />
        {main}
      </div>
    </Router>
  );
});
