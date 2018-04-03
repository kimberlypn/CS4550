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
  return (
    <Router>
      <div>
        <Nav />
        <Route path="/" exact={true} render={() =>
          <div>
            <Dashboard tasks={props.tasks} />
          </div>
        } />
      <Route path="/tasks" exact={true} render={() =>
          <TaskForm />
        } />
      </div>
    </Router>
  );
});
