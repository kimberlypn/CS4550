import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';

export default function run_game(root, channel) {
  ReactDOM.render(<MemoryGame channel={channel}/>, root);
}

class MemoryGame extends React.Component {
  constructor(props) {
    super(props);
    this.channel = props.channel;
    this.state = {
      matches: 0,  // number of matches so far
      clicks: 0,   // number of clicks so far
      flipped: 0,  // number of cards currently flipped
      prev: null,  // previous card that was flipped
      ready: true, // false if a turn is still in progress
      cards: [], // shuffled deck of cards
    };
    this.channel.join()
    .receive("ok", this.gotView.bind(this))
    .receive("error", resp => { console.log("Unable to join", resp) });
  }

  gotView(view) {
    this.setState(view.game);
  }

  sendCard(card) {
    this.channel.push("clicked", { card: card })
    .receive("ok", this.gotView.bind(this));
  }

  // Renders the game board
  render() {
    console.log(this.state)
    let cards = _.map(this.state.cards, (card, ii) => {
      return <RenderCards card={card} clicked={this.sendCard.bind(this)} key={ii}/>;
    });
    return (
      <div>
        <div className="row">
          <div className="col-6">
            <p>NUMBER OF CLICKS: {this.state.clicks}</p>
          </div>
        </div>
        <div className="row">
          {cards}
        </div>
      </div>
    )
  }
}

// Renders each individual card
function RenderCards(props) {
  let card = props.card;
  // If the card is neither flipped nor matched, display a question mark
  let text = "?";
  // If the card is flipped, display the letter
  if (card.flipped) {
    text = card.letter;
  }
  // If the card has been matched, display a thumbs up icon
  if (card.matched) {
    text = <img src="/images/thumbsup.png" />
  }
  return (
    <div className="col-3 text-center">
      <div className="letter" onClick={() => props.clicked(card)}>
        {text}
      </div>
    </div>
  )
}
