import { useParams, Link } from 'react-router-dom';
import { eventsData } from '../data/eventsData';
import './EventDetail.css';

function EventDetail() {
  const { id } = useParams();
  const event = eventsData.find(e => e.id === parseInt(id));

  if (!event) {
    return (
      <div className="event-detail-container">
        <div className="error-message">
          <h2>Event Not Found</h2>
          <p>The event you're looking for doesn't exist.</p>
          <Link to="/" className="back-link">← Back to Events</Link>
        </div>
      </div>
    );
  }

  const registrationStatus = event.currentParticipants >= event.maxParticipants;
  const registrationPercentage = (event.currentParticipants / event.maxParticipants) * 100;

  return (
    <div className="event-detail-container">
      <div className="event-detail-header">
        <Link to="/" className="back-link">← Back to Events</Link>
        <h1>{event.title}</h1>
        <span className="event-category">{event.category}</span>
      </div>

      <div className="event-detail-content">
        <div className="event-image-section">
          <img src={event.image} alt={event.title} className="event-image" />
          <div className="registration-status">
            <div className="progress-bar">
              <div 
                className="progress-fill" 
                style={{ width: `${registrationPercentage}%` }}
              ></div>
            </div>
            <p>
              {event.currentParticipants}/{event.maxParticipants} participants registered
            </p>
            {registrationStatus && (
              <span className="status-full">Registration Closed</span>
            )}
          </div>
        </div>

        <div className="event-info-section">
          <div className="event-description">
            <h2>About Event</h2>
            <p>{event.description}</p>
          </div>

          <div className="event-details-grid">
            <div className="detail-item">
              <h3>📅 Date & Time</h3>
              <p>{event.date}</p>
              <p>{event.startTime} - {event.endTime}</p>
            </div>

            <div className="detail-item">
              <h3>📍 Venue</h3>
              <p>{event.venue}</p>
            </div>

            <div className="detail-item">
              <h3>💰 Registration Fee</h3>
              <p>{event.fee}</p>
            </div>

            <div className="detail-item">
              <h3>⏰ Registration Deadline</h3>
              <p>{event.registrationDeadline}</p>
            </div>

            <div className="detail-item">
              <h3>👥 Organizer</h3>
              <p>{event.organizer}</p>
            </div>

            <div className="detail-item">
              <h3>🌟 Guest Speaker</h3>
              <p>{event.guest}</p>
            </div>
          </div>

          <div className="event-agenda">
            <h2>Agenda</h2>
            <ul>
              {event.agenda.map((item, index) => (
                <li key={index}>{item}</li>
              ))}
            </ul>
          </div>

          <div className="event-requirements">
            <h2>Requirements</h2>
            <p>{event.requirements}</p>
          </div>

          <div className="event-contact">
            <h2>Contact Information</h2>
            <p>📧 {event.contact}</p>
          </div>

          <div className="event-actions">
            <Link to="/register" className="btn-primary">
              Register Now
            </Link>
            <button className="btn-secondary" onClick={() => window.print()}>
              Print Details
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default EventDetail;
