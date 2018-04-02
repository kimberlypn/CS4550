import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Route } from 'react-router-dom';

export default function tasks3_init() {
  let root = document.getElementById('root');
  ReactDOM.render(<Tasks3 />, root);
}

class Tasks3 extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      tasks: [],
      users: [],
    };
  }

  render() {
    return (
      <Router>
        <div>
        </div>
      </Router>
    );
  }
}
