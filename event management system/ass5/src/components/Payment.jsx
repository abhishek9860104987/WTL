import { useState, useEffect } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import QRCode from 'qrcode';
import './Payment.css';

function Payment() {
  const location = useLocation();
  const navigate = useNavigate();
  const [qrCodeUrl, setQrCodeUrl] = useState('');
  const [paymentStatus, setPaymentStatus] = useState('pending');
  const [timeLeft, setTimeLeft] = useState(300); 
  const [registrationData, setRegistrationData] = useState(null);

  useEffect(() => {
    if (location.state?.registrationData) {
      setRegistrationData(location.state.registrationData);
      generateQRCode(location.state.registrationData);
    } else {
      navigate('/register');
    }
  }, [location.state, navigate]);

  useEffect(() => {
    if (timeLeft > 0 && paymentStatus === 'pending') {
      const timer = setTimeout(() => setTimeLeft(timeLeft - 1), 1000);
      return () => clearTimeout(timer);
    } else if (timeLeft === 0 && paymentStatus === 'pending') {
      setPaymentStatus('timeout');
    }
  }, [timeLeft, paymentStatus]);

  const generateQRCode = async (data) => {
    try {
      const paymentInfo = {
        upiId: '9860104987@axl',
        amount: calculateTotalAmount(data),
        transactionId: `TXN${Date.now()}`,
        eventName: data.events.join(', '),
        studentName: `${data.firstName} ${data.lastName}`
      };

      const upiUrl = `upi://pay?pa=${paymentInfo.upiId}&am=${paymentInfo.amount}&cu=INR&tn=${paymentInfo.transactionId}`;
      const qrCodeDataUrl = await QRCode.toDataURL(upiUrl);
      setQrCodeUrl(qrCodeDataUrl);
    } catch (error) {
      console.error('Error generating QR code:', error);
    }
  };

  const calculateTotalAmount = (data) => {
    const eventFees = {
      'Technical Workshop': 0,
      'Cultural Festival': 200,
      'Sports Meet': 50,
      'Hackathon': 0,
      'Seminar': 0,
      'Guest Lecture': 0
    };

    return data.events.reduce((total, event) => {
      return total + (eventFees[event] || 0);
    }, 0);
  };

  const formatTime = (seconds) => {
    const minutes = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${minutes}:${secs.toString().padStart(2, '0')}`;
  };

  const handlePaymentConfirmation = () => {
    setPaymentStatus('processing');
    setTimeout(() => {
      setPaymentStatus('completed');
      setTimeout(() => {
        navigate('/ticket', { state: { registrationData } });
      }, 2000);
    }, 3000);
  };

  const handleCancelPayment = () => {
    navigate('/register');
  };

  if (!registrationData) {
    return <div className="payment-container">Loading...</div>;
  }

  const totalAmount = calculateTotalAmount(registrationData);

  return (
    <div className="payment-container">
      <div className="payment-card">
        <div className="payment-header">
          <h2>Complete Your Payment</h2>
          <p>Scan the QR code to pay for your event registration</p>
        </div>

        <div className="payment-details">
          <div className="event-summary">
            <h3>Registration Summary</h3>
            <div className="summary-item">
              <span>Name:</span>
              <span>{registrationData.firstName} {registrationData.lastName}</span>
            </div>
            <div className="summary-item">
              <span>Student ID:</span>
              <span>{registrationData.studentId}</span>
            </div>
            <div className="summary-item">
              <span>Events:</span>
              <span>{registrationData.events.join(', ')}</span>
            </div>
            <div className="summary-item total">
              <span>Total Amount:</span>
              <span>₹{totalAmount}</span>
            </div>
          </div>

          <div className="qr-section">
            <div className="timer">
              <span className={`timer-text ${timeLeft < 60 ? 'warning' : ''}`}>
                Time remaining: {formatTime(timeLeft)}
              </span>
            </div>

            {qrCodeUrl && (
              <div className="qr-code-container">
                <img src={qrCodeUrl} alt="Payment QR Code" className="qr-code" />
                <p className="scan-instruction">Scan with any UPI app</p>
              </div>
            )}

            <div className="payment-info">
              <p><strong>UPI ID:</strong> 9860104987@axl</p>
              <p><strong>Amount:</strong> ₹{totalAmount}</p>
            </div>
          </div>
        </div>

        <div className="payment-actions">
          {paymentStatus === 'pending' && (
            <>
              <button onClick={handlePaymentConfirmation} className="btn-primary">
                I Have Paid
              </button>
              <button onClick={handleCancelPayment} className="btn-secondary">
                Cancel
              </button>
            </>
          )}

          {paymentStatus === 'processing' && (
            <div className="processing-message">
              <div className="spinner"></div>
              <p>Processing payment...</p>
            </div>
          )}

          {paymentStatus === 'completed' && (
            <div className="success-message">
              <p>✓ Payment Successful!</p>
              <p>Redirecting to ticket generation...</p>
            </div>
          )}

          {paymentStatus === 'timeout' && (
            <div className="timeout-message">
              <p>⚠ Payment session expired</p>
              <button onClick={() => navigate('/register')} className="btn-primary">
                Try Again
              </button>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

export default Payment;
