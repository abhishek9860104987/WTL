import { useRef } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { useReactToPrint } from 'react-to-print';
import './Ticket.css';

function Ticket() {
  const location = useLocation();
  const navigate = useNavigate();
  const ticketRef = useRef();

  if (!location.state?.registrationData) {
    navigate('/register');
    return null;
  }

  const registrationData = location.state.registrationData;
  const ticketNumber = `TKT${Date.now().toString().slice(-6)}`;
  const currentDate = new Date().toLocaleDateString('en-IN');

  const handlePrint = useReactToPrint({
    content: () => ticketRef.current,
    documentTitle: `Event Ticket - ${registrationData.firstName} ${registrationData.lastName}`,
  });

  const handleBackToHome = () => {
    navigate('/');
  };

  return (
    <div className="ticket-container">
      <div className="ticket-header">
        <h2>Your Event Ticket</h2>
        <p>Registration successful! Here are your event tickets.</p>
      </div>

      <div className="ticket-content">
        {registrationData.events.map((event, index) => (
          <div key={index} className="ticket-wrapper" ref={index === 0 ? ticketRef : null}>
            <div className="ticket">
              <div className="ticket-left">
                <div className="event-info">
                  <h3>{event}</h3>
                  <div className="ticket-details">
                    <div className="detail-row">
                      <span className="label">Name:</span>
                      <span className="value">{registrationData.firstName} {registrationData.lastName}</span>
                    </div>
                    <div className="detail-row">
                      <span className="label">Student ID:</span>
                      <span className="value">{registrationData.studentId}</span>
                    </div>
                    <div className="detail-row">
                      <span className="label">Department:</span>
                      <span className="value">{registrationData.department}</span>
                    </div>
                    <div className="detail-row">
                      <span className="label">Year:</span>
                      <span className="value">{registrationData.year}</span>
                    </div>
                    <div className="detail-row">
                      <span className="label">Email:</span>
                      <span className="value">{registrationData.email}</span>
                    </div>
                    <div className="detail-row">
                      <span className="label">Phone:</span>
                      <span className="value">{registrationData.phone}</span>
                    </div>
                  </div>
                </div>
              </div>

              <div className="ticket-right">
                <div className="ticket-header-info">
                  <div className="ticket-number">
                    <span className="label">Ticket No:</span>
                    <span className="value">{ticketNumber}</span>
                  </div>
                  <div className="issue-date">
                    <span className="label">Issued on:</span>
                    <span className="value">{currentDate}</span>
                  </div>
                </div>

                <div className="qr-section">
                  <div className="qr-placeholder">
                    <div className="qr-pattern">
                      <div className="qr-square"></div>
                      <div className="qr-square"></div>
                      <div className="qr-square"></div>
                      <div className="qr-square"></div>
                      <div className="qr-square"></div>
                      <div className="qr-square"></div>
                    </div>
                  </div>
                  <p className="qr-text">SCAN QR CODE</p>
                </div>

                <div className="ticket-footer">
                  <div className="barcode">
                    <div className="barcode-lines">
                      <div className="line"></div>
                      <div className="line"></div>
                      <div className="line"></div>
                      <div className="line"></div>
                      <div className="line"></div>
                      <div className="line"></div>
                      <div className="line"></div>
                      <div className="line"></div>
                      <div className="line"></div>
                      <div className="line"></div>
                    </div>
                    <span className="barcode-number">{ticketNumber}</span>
                  </div>
                </div>
              </div>
            </div>
            <div className="ticket-perforation"></div>
          </div>
        ))}
      </div>

      <div className="ticket-actions">
        <button onClick={handlePrint} className="btn-primary">
          Print Tickets
        </button>
        <button onClick={handleBackToHome} className="btn-secondary">
          Back to Home
        </button>
      </div>

      <div className="ticket-instructions">
        <h3>Important Instructions:</h3>
        <ul>
          <li>Please carry a valid college ID card along with this ticket</li>
          <li>Tickets are non-transferable and non-refundable</li>
          <li>Please arrive 15 minutes before the event start time</li>
          <li>This ticket must be presented at the entry point</li>
          <li>For any queries, contact: abhishekchavan2324_it@sanjivani.org.in</li>
        </ul>
      </div>
    </div>
  );
}

export default Ticket;
