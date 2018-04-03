import React from 'react';
import Task from './task';

// Adapted from Nat's lecture notes
export default function Dashboard(props) {
  let tasks = _.map(props.tasks, (tt) => <Task key={tt.id} task={tt} />);

  return (
    <div>
      {tasks}
    </div>
  );
}
