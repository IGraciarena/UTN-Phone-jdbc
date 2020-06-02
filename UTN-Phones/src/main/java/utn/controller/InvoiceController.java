package utn.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import utn.dto.DateDto;
import utn.dto.InvoiceDto;
import utn.dto.InvoicesBetweenDateDto;
import utn.exceptions.AlreadyExistsException;
import utn.exceptions.NoExistsException;
import utn.exceptions.ValidationException;
import utn.model.Invoice;
import utn.service.InvoiceService;

import java.util.List;

@Controller
public class InvoiceController {
    InvoiceService invoiceService;

    @Autowired
    public InvoiceController(InvoiceService invoiceService) {
        this.invoiceService = invoiceService;
    }

    public void add(Invoice invoice) throws AlreadyExistsException {
        invoiceService.add(invoice);
    }

    public void remove(Integer id) throws NoExistsException {
        invoiceService.remove(id);
    }

    public void update(Invoice invoice) throws NoExistsException {
        invoiceService.update(invoice);
    }

    public InvoiceDto getById(Integer id) throws NoExistsException {
        return invoiceService.getById(id);
    }

    public List<InvoiceDto> getAll() {
        return invoiceService.getAll();
    }

    public List<InvoiceDto> getInvoicesBetweenDatesFromUserId(InvoicesBetweenDateDto invoiceDto) throws NoExistsException {
        return invoiceService.getInvoicesBetweenDatesFromUserId(invoiceDto);
    }

    public List<InvoiceDto> getInvoicesByDate(DateDto dateDto) throws ValidationException {
        if(dateDto!=null) {
            return invoiceService.getInvoicesByDate(dateDto);
        }else{
            throw new ValidationException();
        }
    }
}
