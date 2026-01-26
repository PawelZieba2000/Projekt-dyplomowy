unit cTypes;

interface

type
  TScaleConnType = (sctNone, sctSerialPort, sctTcpIp);

  TScaleProtocolType = (sptNone, sptRinstrumC520, sptRhewaDisplay);

  TTransmisionWithDeviceEvent = procedure (pIsConnected : Boolean; pStatus : Integer = 0) of object;
  TReadMassFromDeviceEvent = procedure (pMassFromDevice : Double; pStatus : Integer = 0) of object;

implementation

end.
