'use client';

import React, { useState } from 'react';
import Layout from '@/components/layout/Layout';
import { useCart } from '@/contexts/CartContext';
import { CheckoutStep, ShippingRate, CheckoutData } from '@/types';

const checkoutSteps: CheckoutStep[] = [
  { id: 'shipping', title: 'Shipping', completed: false, current: true },
  { id: 'payment', title: 'Payment', completed: false, current: false },
  { id: 'review', title: 'Review', completed: false, current: false },
];

const shippingRates: ShippingRate[] = [
  {
    id: 'standard',
    title: 'Standard Shipping',
    price: 10,
    estimated_days: 5,
    description: '5-7 business days'
  },
  {
    id: 'express',
    title: 'Express Shipping',
    price: 20,
    estimated_days: 2,
    description: '2-3 business days'
  },
  {
    id: 'overnight',
    title: 'Overnight Shipping',
    price: 35,
    estimated_days: 1,
    description: 'Next business day'
  }
];

export default function CheckoutPage() {
  const { state } = useCart();
  const [currentStep, setCurrentStep] = useState(0);
  const [checkoutData, setCheckoutData] = useState<CheckoutData>({
    email: '',
    shipping_address: {
      first_name: '',
      last_name: '',
      address1: '',
      address2: '',
      city: '',
      state: '',
      zip: '',
      country: 'US'
    },
    billing_address: {
      first_name: '',
      last_name: '',
      address1: '',
      address2: '',
      city: '',
      state: '',
      zip: '',
      country: 'US'
    },
    same_as_shipping: true
  });
  const [selectedShipping, setSelectedShipping] = useState<ShippingRate | null>(null);
  const [errors, setErrors] = useState<Record<string, string>>({});

  if (state.items.length === 0) {
    return (
      <Layout>
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
          <div className="text-center">
            <h1 className="text-2xl font-heading font-light text-text-primary mb-4">
              Your cart is empty
            </h1>
            <p className="text-text-muted mb-8">
              Add some items to your cart before checking out.
            </p>
            <a href="/collections/all" className="btn-primary">
              Continue Shopping
            </a>
          </div>
        </div>
      </Layout>
    );
  }

  const validateStep = (step: number): boolean => {
    const newErrors: Record<string, string> = {};

    if (step === 0) {
      if (!checkoutData.email) newErrors.email = 'Email is required';
      if (!checkoutData.shipping_address.first_name) newErrors.first_name = 'First name is required';
      if (!checkoutData.shipping_address.last_name) newErrors.last_name = 'Last name is required';
      if (!checkoutData.shipping_address.address1) newErrors.address1 = 'Address is required';
      if (!checkoutData.shipping_address.city) newErrors.city = 'City is required';
      if (!checkoutData.shipping_address.state) newErrors.state = 'State is required';
      if (!checkoutData.shipping_address.zip) newErrors.zip = 'ZIP code is required';
      if (!selectedShipping) newErrors.shipping = 'Please select a shipping method';
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleNext = () => {
    if (validateStep(currentStep)) {
      setCurrentStep(currentStep + 1);
    }
  };

  const handlePrevious = () => {
    setCurrentStep(currentStep - 1);
  };

  const handleSubmit = () => {
    if (validateStep(currentStep)) {
      // Process order
      console.log('Processing order...', { checkoutData, selectedShipping });
      alert('Order placed successfully!');
    }
  };

  const renderShippingStep = () => (
    <div className="space-y-6">
      <div>
        <h2 className="text-2xl font-heading font-light text-text-primary mb-6">
          Shipping Information
        </h2>
        
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
          <div>
            <label className="form-label">Email</label>
            <input
              type="email"
              value={checkoutData.email}
              onChange={(e) => setCheckoutData({
                ...checkoutData,
                email: e.target.value
              })}
              className="form-input"
            />
            {errors.email && <p className="form-error">{errors.email}</p>}
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mt-6">
          <div>
            <label className="form-label">First Name</label>
            <input
              type="text"
              value={checkoutData.shipping_address.first_name}
              onChange={(e) => setCheckoutData({
                ...checkoutData,
                shipping_address: {
                  ...checkoutData.shipping_address,
                  first_name: e.target.value
                }
              })}
              className="form-input"
            />
            {errors.first_name && <p className="form-error">{errors.first_name}</p>}
          </div>
          <div>
            <label className="form-label">Last Name</label>
            <input
              type="text"
              value={checkoutData.shipping_address.last_name}
              onChange={(e) => setCheckoutData({
                ...checkoutData,
                shipping_address: {
                  ...checkoutData.shipping_address,
                  last_name: e.target.value
                }
              })}
              className="form-input"
            />
            {errors.last_name && <p className="form-error">{errors.last_name}</p>}
          </div>
        </div>

        <div className="mt-6">
          <label className="form-label">Address</label>
          <input
            type="text"
            value={checkoutData.shipping_address.address1}
            onChange={(e) => setCheckoutData({
              ...checkoutData,
              shipping_address: {
                ...checkoutData.shipping_address,
                address1: e.target.value
              }
            })}
            className="form-input"
          />
          {errors.address1 && <p className="form-error">{errors.address1}</p>}
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mt-6">
          <div>
            <label className="form-label">City</label>
            <input
              type="text"
              value={checkoutData.shipping_address.city}
              onChange={(e) => setCheckoutData({
                ...checkoutData,
                shipping_address: {
                  ...checkoutData.shipping_address,
                  city: e.target.value
                }
              })}
              className="form-input"
            />
            {errors.city && <p className="form-error">{errors.city}</p>}
          </div>
          <div>
            <label className="form-label">State</label>
            <select
              value={checkoutData.shipping_address.state}
              onChange={(e) => setCheckoutData({
                ...checkoutData,
                shipping_address: {
                  ...checkoutData.shipping_address,
                  state: e.target.value
                }
              })}
              className="form-input"
            >
              <option value="">Select State</option>
              <option value="CA">California</option>
              <option value="NY">New York</option>
              <option value="TX">Texas</option>
              <option value="FL">Florida</option>
            </select>
            {errors.state && <p className="form-error">{errors.state}</p>}
          </div>
          <div>
            <label className="form-label">ZIP Code</label>
            <input
              type="text"
              value={checkoutData.shipping_address.zip}
              onChange={(e) => setCheckoutData({
                ...checkoutData,
                shipping_address: {
                  ...checkoutData.shipping_address,
                  zip: e.target.value
                }
              })}
              className="form-input"
            />
            {errors.zip && <p className="form-error">{errors.zip}</p>}
          </div>
        </div>
      </div>

      <div>
        <h3 className="text-lg font-semibold text-text-primary mb-4">Shipping Method</h3>
        <div className="space-y-3">
          {shippingRates.map((rate) => (
            <label key={rate.id} className="flex items-center p-4 border border-gray-200 rounded-lg cursor-pointer hover:bg-gray-50">
              <input
                type="radio"
                name="shipping"
                value={rate.id}
                checked={selectedShipping?.id === rate.id}
                onChange={() => setSelectedShipping(rate)}
                className="mr-3"
              />
              <div className="flex-1">
                <div className="flex justify-between items-center">
                  <span className="font-medium text-text-primary">{rate.title}</span>
                  <span className="text-leather-accent font-semibold">
                    {rate.price === 0 ? 'Free' : `$${rate.price}`}
                  </span>
                </div>
                <p className="text-sm text-text-muted">{rate.description}</p>
              </div>
            </label>
          ))}
        </div>
        {errors.shipping && <p className="form-error mt-2">{errors.shipping}</p>}
      </div>
    </div>
  );

  const renderPaymentStep = () => (
    <div className="space-y-6">
      <h2 className="text-2xl font-heading font-light text-text-primary mb-6">
        Payment Information
      </h2>
      
      <div className="bg-gray-50 p-6 rounded-lg">
        <h3 className="text-lg font-semibold text-text-primary mb-4">Card Information</h3>
        <div className="space-y-4">
          <div>
            <label className="form-label">Card Number</label>
            <input
              type="text"
              placeholder="1234 5678 9012 3456"
              className="form-input"
            />
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="form-label">Expiry Date</label>
              <input
                type="text"
                placeholder="MM/YY"
                className="form-input"
              />
            </div>
            <div>
              <label className="form-label">CVV</label>
              <input
                type="text"
                placeholder="123"
                className="form-input"
              />
            </div>
          </div>
        </div>
      </div>

      <div>
        <label className="flex items-center space-x-2">
          <input
            type="checkbox"
            checked={checkoutData.same_as_shipping}
            onChange={(e) => setCheckoutData({
              ...checkoutData,
              same_as_shipping: e.target.checked
            })}
            className="rounded border-gray-300 text-leather-accent focus:ring-leather-accent"
          />
          <span className="text-sm text-text-muted">Billing address same as shipping</span>
        </label>
      </div>
    </div>
  );

  const renderReviewStep = () => (
    <div className="space-y-6">
      <h2 className="text-2xl font-heading font-light text-text-primary mb-6">
        Review Your Order
      </h2>
      
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
        <div>
          <h3 className="text-lg font-semibold text-text-primary mb-4">Order Summary</h3>
          <div className="space-y-4">
            {state.items.map((item) => (
              <div key={item.id} className="flex items-center space-x-4 p-4 border border-gray-200 rounded-lg">
                <div className="w-16 h-16 bg-gray-100 rounded"></div>
                <div className="flex-1">
                  <h4 className="font-medium text-text-primary">{item.product.title}</h4>
                  <p className="text-sm text-text-muted">{item.variant.title}</p>
                  {item.personalization && (
                    <p className="text-sm text-leather-accent">
                      Personalization: {item.personalization.text}
                    </p>
                  )}
                  <p className="text-sm text-text-muted">Qty: {item.quantity}</p>
                </div>
                <div className="text-right">
                  <p className="font-semibold text-text-primary">
                    ${((item.variant.price + (item.personalization ? 15 : 0)) * item.quantity).toFixed(2)}
                  </p>
                </div>
              </div>
            ))}
          </div>
        </div>

        <div>
          <h3 className="text-lg font-semibold text-text-primary mb-4">Order Total</h3>
          <div className="bg-gray-50 p-6 rounded-lg space-y-3">
            <div className="flex justify-between">
              <span>Subtotal</span>
              <span>${state.subtotal.toFixed(2)}</span>
            </div>
            <div className="flex justify-between">
              <span>Shipping</span>
              <span>{selectedShipping ? (selectedShipping.price === 0 ? 'Free' : `$${selectedShipping.price}`) : '$0'}</span>
            </div>
            <div className="flex justify-between">
              <span>Tax</span>
              <span>${state.tax.toFixed(2)}</span>
            </div>
            <div className="border-t border-gray-200 pt-3">
              <div className="flex justify-between text-lg font-semibold">
                <span>Total</span>
                <span>${(state.total + (selectedShipping?.price || 0)).toFixed(2)}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );

  const renderStepContent = () => {
    switch (currentStep) {
      case 0:
        return renderShippingStep();
      case 1:
        return renderPaymentStep();
      case 2:
        return renderReviewStep();
      default:
        return null;
    }
  };

  return (
    <Layout>
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {/* Progress Steps */}
        <div className="mb-8">
          <div className="flex items-center justify-between">
            {checkoutSteps.map((step, index) => (
              <div key={step.id} className="flex items-center">
                <div className={`w-8 h-8 rounded-full flex items-center justify-center text-sm font-medium ${
                  index <= currentStep
                    ? 'bg-leather-accent text-white'
                    : 'bg-gray-200 text-gray-600'
                }`}>
                  {index + 1}
                </div>
                <span className={`ml-2 text-sm font-medium ${
                  index <= currentStep ? 'text-leather-accent' : 'text-gray-600'
                }`}>
                  {step.title}
                </span>
                {index < checkoutSteps.length - 1 && (
                  <div className={`w-16 h-0.5 mx-4 ${
                    index < currentStep ? 'bg-leather-accent' : 'bg-gray-200'
                  }`} />
                )}
              </div>
            ))}
          </div>
        </div>

        {/* Step Content */}
        <div className="max-w-4xl mx-auto">
          {renderStepContent()}
        </div>

        {/* Navigation */}
        <div className="max-w-4xl mx-auto mt-8 flex justify-between">
          <button
            onClick={handlePrevious}
            disabled={currentStep === 0}
            className="btn-outline disabled:opacity-50 disabled:cursor-not-allowed"
          >
            Previous
          </button>
          
          {currentStep < checkoutSteps.length - 1 ? (
            <button onClick={handleNext} className="btn-primary">
              Continue
            </button>
          ) : (
            <button onClick={handleSubmit} className="btn-primary">
              Place Order
            </button>
          )}
        </div>
      </div>
    </Layout>
  );
}
