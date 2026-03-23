import { Link } from 'react-router-dom';
import { eventsData } from '../data/eventsData';
import './Home.css';

function Home() {
  return (
    <div className="home-container">
      <div className="hero-section">
        <h1>College Event Management System</h1>
        <p>Register and participate in exciting college events</p>
        <div className="cta-buttons">
          <Link to="/register" className="btn-primary">
            Register for Events
          </Link>
        </div>
      </div>
      
      <div className="features-section">
        <h2>Upcoming Events</h2>
        <div className="events-grid">
          {eventsData.map(event => (
            <Link to={`/events/${event.id}`} key={event.id} className="event-card-link">
              <div className="event-card">
                <h3>{event.title}</h3>
                <p>{event.description}</p>
                <span className="event-date">{event.date}</span>
                <div className="event-meta">
                  <span className="event-fee">{event.fee}</span>
                  <span className="event-participants">
                    {event.currentParticipants}/{event.maxParticipants} registered
                  </span>
                </div>
              </div>
            </Link>
          ))}
        </div>
      </div>
    </div>
  );
}

export default Home;
