import React from 'react';
import ReactDOM from 'react-dom';
import { Provider, connect } from 'react-redux';
import { BrowserRouter as Router, Route } from 'react-router-dom';

import Nav from './nav';
import NoSession from './no-session';
import Main from './main';

// Renders the main application; adapted from Nat's lecture notes
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
  let main = !props.form.token ? <NoSession /> :
  <Main tasks={props.tasks} user={props.form.creator_id} />;

  return (
    <Router>
      <div>
        <Nav />
        {main}
      </div>
    </Router>
  );
});
